import os
from dotenv import load_dotenv
from database import engine
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from models.base import Base
from routes import auth
from routes import song

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # List of allowed origins
    allow_methods=["*"],    # Allow all HTTP methods (GET, POST, PUT, DELETE, etc.)
    allow_headers=["*"],    # Allow all headers
)

app.include_router(auth.router, prefix = '/auth')
app.include_router(song.router, prefix = '/song')

Base.metadata.create_all(engine)