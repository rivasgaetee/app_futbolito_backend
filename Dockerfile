# Usar la imagen base de Python
FROM python:3.10-slim

# Instalar herramientas básicas y dependencias del sistema
RUN apt-get update && apt-get install -y --no-install-recommends \
    procps net-tools && \
    rm -rf /var/lib/apt/lists/*

# Configurar directorio de trabajo
WORKDIR /app

# Copiar y ejecutar dependencias
COPY requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

# Copiar el código fuente
COPY . /app/

# Exponer el puerto 8000
EXPOSE 8000

# Comando por defecto
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]