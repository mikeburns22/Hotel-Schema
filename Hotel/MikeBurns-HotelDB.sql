DROP DATABASE IF EXISTS HotelSchema;
CREATE DATABASE HotelSchema;

USE HotelSchema;

CREATE TABLE RoomType (
	RoomTypeId INT PRIMARY KEY AUTO_INCREMENT,
    RoomType VARCHAR(20),
    RoomOccupancy INT,
    MaxRoomOccupancy INT,
    ExtraPersonFee DECIMAL(5, 2),
    Price DECIMAL(6, 2)
);

CREATE TABLE Room (
	RoomNumber INT PRIMARY KEY,
    RoomTypeId INT,
	FOREIGN KEY fk_Room_RoomType (RoomTypeId)
		REFERENCES RoomType (RoomTypeId),
	
    ADA BOOL
);

CREATE TABLE Amenity (
	AmenityId INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(50)
);

CREATE TABLE RoomAmenity (
	RoomAmenityId INT PRIMARY KEY AUTO_INCREMENT,
	RoomNumber INT,
    FOREIGN KEY fk_Room_RoomAmenity (RoomNumber)
		REFERENCES Room (RoomNumber),
        
    AmenityId INT,
    FOREIGN KEY fk_Amenity_RoomAmenity (AmenityId)
		REFERENCES Amenity(AmenityId)
);

CREATE TABLE Guest (
	GuestId INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(30),
    LastName VARCHAR(30),
    Address VARCHAR(60),
    City VARCHAR(30),
    State CHAR(2),
    Zipcode CHAR(5),
    Phone CHAR(10)
);

CREATE TABLE Reservation (
	ReservationId INT PRIMARY KEY AUTO_INCREMENT,
    RoomNumber INT,
    FOREIGN KEY fk_Reservation_Room (RoomNumber)
		REFERENCES Room (RoomNumber),
        
	GuestId INT,
    FOREIGN KEY fk_Reservation_Guest (GuestId)
		REFERENCES Guest (GuestId),
        
	StartDate DATE,
    EndDate DATE,
    Adults INT,
    Children INT
);