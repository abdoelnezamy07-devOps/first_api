from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from typing import List, Optional
from uuid import UUID, uuid4

app = FastAPI()

#its like a database to store data i wrote in the same session
# b4 reload to update or something else... and i can write anything in
#and it will be permenant data ... if you deleted a class you can use
#dict{} and write data in it to be a data structural ypu wanna use with your code
cars={uuid4()
    :{
        "country":"Germany",
        "brand":"Mercedes",
        "model":"GLC",
        "year":2026
    }
}


''' class means its something im ganna do frequently in my code 
and every class must have object like Cars in our project and 
might has something to range it too as here (basemodel)
its a data structural to organize my send and resieve data....'''

'''here im gonna write my data structure 
like every thing i wanna know / put in my app and web
 lets say wanna put an id , name , type and so on ....
 and how i wanna sent and resieve it'''

class Cars(BaseModel):
    name:str
    country:str
    brand:str
    model:str
    year:int
class UpdateCar(BaseModel):
    name: Optional[str]=None
    country: Optional[str]=None
    brand: Optional[str]=None
    model: Optional[str]=None
    year: Optional[int]=None

#Endpoint (URL)
#www.Famcars.com/
@app.get("/")
def get_root():
    return {"Hello":'im Abdelrhman'}


#www.Famcars.com/cars
@app.get("/cars/")
def get_all_cars():
    return cars


#www.Famcars.com/cars/1
#GET Cars
@app.get("/cars/{car_id}")
def get_cars(car_id:UUID):
    if car_id not in cars:
        raise HTTPException(status_code=404,detail="car not found!")
    return cars[car_id]

@app.post("/cars/", response_model=Cars)
def create_cars(car:Cars):
    car_id=uuid4()
    if car_id in car:
        raise HTTPException(status_code=404,detail="car already exist!")
    cars[car_id]=car.dict()
    return car

#UPDATE
#www.Famcars.com/cars/1
#PUT Cars
@app.put("/cars/{car_id}", response_model=UpdateCar)
def update_car(car_id:UUID,car:UpdateCar):
        if car_id not in cars:
            raise HTTPException(status_code=404, detail="Car is not Found")
        current_car= cars[car_id]
        if car.name is not None:
            current_car["name"]=car.name
        if car.country is not None:
            current_car["country"] = car.country
        if car.brand is not None:
            current_car["brand"] = car.brand
        if car.model is not None:
            current_car["model"] = car.model
        if car.year is not None:
            current_car["year"] = car.year

        return current_car

#DELETE
#www.Famcars.com/cars/1
#DELETE Cars
@app.delete("/cars/{car_id}")
def deleted_car(car_id:UUID):
#def deleted_car(car_id:int):
    if car_id not in cars:
        HTTPException(status_code=404, detail="Car is not here")

    removed_car=cars.pop(car_id)
    return {"massage":"car has been deleted", "deleted_car":removed_car}













# if __name__ == "__main__":
#     import uvicorn
#     uvicorn.run(app,host="0.0.0.0",port=8000)







