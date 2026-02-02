from sqlalchemy import TEXT, VARCHAR, Column
from models.base import Base


class Song(Base):
    __tablename__ = 'songs'
    id = Column(TEXT, primary_key = True)
    url = Column(TEXT)
    thumbnail = Column(TEXT)
    artist = Column(TEXT)
    name = Column(VARCHAR(100))
    color = Column(VARCHAR(6))