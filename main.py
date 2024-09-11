import base64
import os
from fastapi import FastAPI, Depends, HTTPException
from sqlalchemy.orm import Session
from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker
from pydantic import BaseModel
from typing import List
from dotenv import load_dotenv
from models import Base, User, IncidenceType, Incidence, Location, MaintenanceType, Maintenance, IncidencePicture, MaintenancePicture

# Cargar las variables del archivo .env
load_dotenv()

# Configuración de la base de datos usando variables de entorno
DATABASE_URL = f"mysql+pymysql://{os.getenv('DB_USERNAME')}:{os.getenv('DB_PASSWORD')}@{os.getenv('DB_HOST')}:{os.getenv('DB_PORT')}/{os.getenv('DB_NAME')}"

engine = create_engine(DATABASE_URL)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

Base.metadata.create_all(bind=engine)

app = FastAPI()

# Dependencia para obtener la sesión de la base de datos
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

# Modelos Pydantic
class UserCreate(BaseModel):
    username: str
    password: str

class IncidenceTypeCreate(BaseModel):
    name: str

class IncidenceCreate(BaseModel):
    comment: str
    datetime: str
    id_user: int
    id_incidence_type: int
    pictures: List[str]
    
class IncidencePictureResponse(BaseModel):
    id_picture: int
    picture: bytes
    datetime: str

    class Config:
        from_attributes = True

class IncidenceResponse(BaseModel):
    id_incidence: int
    comment: str
    datetime: str
    id_user: int
    id_incidence_type: int
    pictures: List[IncidencePictureResponse]

    class Config:
        from_attributes = True

class LocationCreate(BaseModel):
    name: str
    description: str
    lat: str
    long: str
    
class MaintenanceCreate(BaseModel):
    comment: str
    datetime: str
    id_maintenance_type: int
    id_user: int
    location: LocationCreate
    pictures: List[str]  # Aquí se espera recibir las imágenes en formato base64

    class Config:
        from_attributes = True

class MaintenancePictureResponse(BaseModel):
    id_picture: int
    picture: bytes
    datetime: str

    class Config:
        from_attributes = True

class MaintenanceResponse(BaseModel):
    id_maintenance: int
    comment: str
    datetime: str
    id_maintenance_type: int
    id_user: int
    id_location: int
    pictures: List[MaintenancePictureResponse]

    class Config:
        from_attributes = True
        
class MaintenanceTypeCreate(BaseModel):
    name: str


class UserLogin(BaseModel):
    username: str
    password: str
   
# Rutas POST
@app.post("/users/")
def create_user(user: UserCreate, db: Session = Depends(get_db)):
    db_user = User(username=user.username, password=user.password)
    db.add(db_user)
    db.commit()
    db.refresh(db_user)
    return db_user

@app.get("/users/")
def read_users(db: Session = Depends(get_db)):
    users = db.query(User).all()
    return users

@app.post("/incidence_types/")
def create_incidence_type(incidence_type: IncidenceTypeCreate, db: Session = Depends(get_db)):
    db_incidence_type = IncidenceType(name=incidence_type.name)
    db.add(db_incidence_type)
    db.commit()
    db.refresh(db_incidence_type)
    return db_incidence_type

@app.post("/incidences/")
def create_incidence(incidence: IncidenceCreate, db: Session = Depends(get_db)):
    # Crear la incidencia
    db_incidence = Incidence(
        comment=incidence.comment, 
        datetime=incidence.datetime, 
        id_user=incidence.id_user, 
        id_incidence_type=incidence.id_incidence_type
    )
    db.add(db_incidence)
    db.commit()
    db.refresh(db_incidence)
    
    # Guardar cada imagen en la tabla incidence_pictures
    for picture in incidence.pictures:
        db_picture = IncidencePicture(
            picture=picture.encode('utf-8'),  # Convertir base64 a bytes
            datetime=incidence.datetime,
            id_incidence=db_incidence.id_incidence
        )
        db.add(db_picture)
    
    db.commit()

    return db_incidence

# Rutas GET


@app.get("/incidence_types/")
def read_incidence_types(db: Session = Depends(get_db)):
    incidence_types = db.query(IncidenceType).all()
    return incidence_types

@app.get("/incidences/", response_model=List[IncidenceResponse])
def read_incidences(db: Session = Depends(get_db)):
    incidences = db.query(Incidence).all()
    return incidences


@app.post("/maintenances/")
def create_maintenance(maintenance: MaintenanceCreate, db: Session = Depends(get_db)):
    # Crear la location
    db_location = Location(
        name=maintenance.location.name,
        description=maintenance.location.description,
        lat=maintenance.location.lat,
        long=maintenance.location.long
    )
    db.add(db_location)
    db.commit()
    db.refresh(db_location)

    # Crear el mantenimiento con la ubicación recién creada
    db_maintenance = Maintenance(
        comment=maintenance.comment,
        datetime=maintenance.datetime,
        id_maintenance_type=maintenance.id_maintenance_type,
        id_user=maintenance.id_user,
        id_location=db_location.id_location
    )
    db.add(db_maintenance)
    db.commit()
    db.refresh(db_maintenance)

    # Procesar cada imagen enviada en formato Base64
    for picture_base64 in maintenance.pictures:
        # Decodificar la imagen de Base64 a bytes
        picture_bytes = base64.b64decode(picture_base64)

        # Crear el objeto MaintenancePicture con los bytes de la imagen
        db_maintenance_picture = MaintenancePicture(
            picture=picture_bytes,  # Aquí enviamos los bytes, no la cadena Base64
            datetime=maintenance.datetime,
            id_maintenance=db_maintenance.id_maintenance
        )
        db.add(db_maintenance_picture)

    db.commit()

    return db_maintenance


@app.get("/maintenances/", response_model=List[MaintenanceResponse])
def read_maintenances(db: Session = Depends(get_db)):
    maintenances = db.query(Maintenance).all()
    return maintenances

@app.post("/maintenance_types/")
def create_maintenance_type(maintenance_type: MaintenanceTypeCreate, db: Session = Depends(get_db)):
    db_maintenance_type = MaintenanceType(name=maintenance_type.name)
    db.add(db_maintenance_type)
    db.commit()
    db.refresh(db_maintenance_type)
    return db_maintenance_type

@app.get("/maintenance_types/")
def read_maintenance_types(db: Session = Depends(get_db)):
    maintenance_types = db.query(MaintenanceType).all()
    return maintenance_types


@app.post("/users/login")
def login(user: UserLogin, db: Session = Depends(get_db)):
    db_user = db.query(User).filter(User.username == user.username).first()
    if not db_user or not verify_password(user.password, db_user.password):
        raise HTTPException(
            status_code=400, detail="Invalid username or password")
    return {"message": "Login successful", "userId": db_user.id_user}

def verify_password(plain_password, hashed_password):
    return plain_password == hashed_password