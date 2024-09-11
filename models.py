from sqlalchemy import Column, Integer, String, DateTime, ForeignKey, BLOB
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import relationship

Base = declarative_base()

class User(Base):
    __tablename__ = 'users'
    id_user = Column(Integer, primary_key=True, index=True)
    username = Column(String(200), unique=True, index=True)
    password = Column(String(200))

class IncidenceType(Base):
    __tablename__ = 'incidence_types'
    id_incidence_type = Column(Integer, primary_key=True, index=True)
    name = Column(String(45), unique=True)

class Incidence(Base):
    __tablename__ = 'incidences'
    id_incidence = Column(Integer, primary_key=True, index=True)
    comment = Column(String(350))
    datetime = Column(DateTime)
    id_user = Column(Integer, ForeignKey('users.id_user'))
    id_incidence_type = Column(Integer, ForeignKey('incidence_types.id_incidence_type'))
    
    pictures = relationship("IncidencePicture", backref="incidence", cascade="all, delete-orphan")

class Location(Base):
    __tablename__ = 'locations'
    id_location = Column(Integer, primary_key=True, index=True)
    name = Column(String(150))
    description = Column(String(350))
    lat = Column(String(45))
    long = Column(String(45))

class MaintenanceType(Base):
    __tablename__ = 'maintenance_types'
    id_maintenance_type = Column(Integer, primary_key=True, index=True)
    name = Column(String(45), unique=True)

class Maintenance(Base):
    __tablename__ = 'maintenances'
    id_maintenance = Column(Integer, primary_key=True, index=True)
    comment = Column(String(350))
    datetime = Column(DateTime)
    id_maintenance_type = Column(Integer, ForeignKey('maintenance_types.id_maintenance_type'))
    id_location = Column(Integer, ForeignKey('locations.id_location'))
    id_user = Column(Integer, ForeignKey('users.id_user'))
    
    pictures = relationship("MaintenancePicture", backref="maintenance", cascade="all, delete-orphan")

class IncidencePicture(Base):
    __tablename__ = 'incidence_picture'
    id_picture = Column(Integer, primary_key=True, index=True)
    picture = Column(BLOB)
    datetime = Column(DateTime)
    id_incidence = Column(Integer, ForeignKey('incidences.id_incidence'))

class MaintenancePicture(Base):
    __tablename__ = 'maintenance_pictures'
    id_picture = Column(Integer, primary_key=True, index=True)
    picture = Column(BLOB)
    datetime = Column(DateTime)
    id_maintenance = Column(Integer, ForeignKey('maintenances.id_maintenance'))


