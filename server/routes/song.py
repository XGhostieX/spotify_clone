import os
import uuid
import cloudinary
import cloudinary.uploader
from dotenv import load_dotenv
from fastapi import APIRouter, Depends, File, Form, UploadFile
from sqlalchemy.orm import Session, joinedload

from database import get_db
from middlewares.auth_middleware import auth_middleware
from models.favorite import Favorite
from models.song import Song
from pydantic_schemas.favorite_song import FavoriteSong

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

@router.get('/list')
def list_songs(db: Session = Depends(get_db),auth = Depends(auth_middleware)):
    songs = db.query(Song).all()
    return songs

@router.post('/favorite')
def favorite_song(song: FavoriteSong,
                db: Session = Depends(get_db),
                auth = Depends(auth_middleware)):
    user_id = auth['uid']
    favorite_song = db.query(Favorite).filter(Favorite.song_id == song.id, Favorite.user_id == user_id).first()
    if favorite_song:
        db.delete(favorite_song)
        db.commit()
        return {'message': False}
    else:
        db.add(Favorite(id = str(uuid.uuid4()), song_id = song.id, user_id = user_id))
        db.commit()
        return {'message': True}
    
@router.get('/list/favorites')
def list_favorite_songs(db: Session = Depends(get_db),auth = Depends(auth_middleware)):
    favorite_songs = db.query(Favorite).filter(Favorite.user_id == auth['uid']).options(joinedload(Favorite.song)).all()
    return favorite_songs