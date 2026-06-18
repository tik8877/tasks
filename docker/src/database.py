import os
from sqlalchemy.ext.asyncio import create_async_engine, AsyncSession
from sqlalchemy.orm import sessionmaker, declarative_base

DATABASE_URL = os.getenv(
    "DATABASE_URL",
    "postgresql+psycopg://kubsu:kubsu@127.0.0.1:5432/kubsu",
    "postgresql+psycopg://kubsu:kubsu@kubsu-db:5432/kubsu"
)

engine = create_async_engine(
    DATABASE_URL,
    echo=os.getenv("DB_ECHO", "false").lower() == "true"
)

AsyncSessionLocal = sessionmaker(
    bind=engine,
    class_=AsyncSession,
    expire_on_commit=False
)

Base = declarative_base()

async def init_db():
    """Создание таблиц при старте"""
    async with engine.begin() as conn:
        await conn.run_sync(Base.metadata.create_all)

async def get_db():
    """Зависимость FastAPI для получения сессии БД"""
    async with AsyncSessionLocal() as session:
        yield session
