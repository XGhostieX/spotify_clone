import os
import uuid
import cloudinary
import cloudinary.uploader
from dotenv import load_dotenv
from fastapi import APIRouter, Depends, File, Form, UploadFile
from sqlalchemy.orm import Session

from database import get_db
from middlewares.auth_middleware import auth_middleware
from models.song import Song

router = APIRouter()

load_dotenv()

cloudinary.config( 
    cloud_name = "dvmvqoemx", 
    api_key = os.getenv("API_KEY"), 
    api_secret = os.getenv("API_SECRET_KEY"),
    secure=True
)

@router.post('/upload', status_code = 201)
def uplaod_song(song: UploadFile = File(...),
                thumbnail: UploadFile = File(...),
                artist: str = Form(...),
                name:str = Form(...),
                color:str = Form(...),
                db: Session = Depends(get_db),
                auth = Depends(auth_middleware)):
    id = str(uuid.uuid4())
    song_result = cloudinary.uploader.upload(song.file, resource_type = 'auto', folder = f'songs/{id}')
    thumbnail_result = cloudinary.uploader.upload(thumbnail.file, resource_type = 'image', folder = f'songs/{id}')
    song = Song(
        id = id,
        url = song_result['url'],
        thumbnail = thumbnail_result['url'],
        artist = artist,
        name = name,
        color = color
    )
    db.add(song)
    db.commit()
    db.refresh(song)
    return song