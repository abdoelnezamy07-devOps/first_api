#(Base Image)
FROM python:3.11-slim

#(here /app mean name in the fastAPI i used)
WORKDIR /app

#(Copy and Install Dependancies/Libraries)
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

#(Copy all files after install dependancies)
COPY . .

#(Port my app listen to )
EXPOSE 8000

#(Run app/file)
CMD ["uvicorn", "API:app", "--host", "0.0.0.0", "--port", "8000", "--log-config", "Log.yaml"]


