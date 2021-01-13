use hotelschema;

-- 1. Write a query that returns a list of reservations that end in July 2023, including the name of the guest, the room number(s), and the reservation dates.

SELECT
	CONCAT(Guest.LastName, ", ", Guest.FirstName) AS Guest,
    Reservation.RoomNumber,
    CONCAT(Reservation.startDate, " - ", Reservation.endDate) AS TimeReserved
FROM Reservation AS Reservation
INNER JOIN Guest AS Guest
	ON Guest.GuestId = Reservation.GuestId
WHERE Reservation.endDate BETWEEN "2023-07-01" AND "2023-07-30";

-- RESULTS
-- Burns, Michael	205	2023-06-28 - 2023-07-02
-- Holaway, Walter	204	2023-07-13 - 2023-07-14
-- Vise, Wilfred	401	2023-07-18 - 2023-07-21
-- Seery, Bettyann	303	2023-07-28 - 2023-07-29


-- 2. Write a query that returns a list of all reservations for rooms with a jacuzzi, displaying the guest's name, the room number, and the dates of the reservation.

SELECT
	CONCAT(Guest.LastName, ", ", Guest.FirstName) AS Guest,
	Reservation.RoomNumber,
    CONCAT(Reservation.StartDate, " - ", Reservation.EndDate) AS TimeReserved
FROM Reservation AS Reservation
INNER JOIN Guest AS Guest
	ON Reservation.GuestId = Guest.GuestId
INNER JOIN RoomAmenity AS RoomAmenity
	ON Reservation.RoomNumber = RoomAmenity.RoomNumber
INNER JOIN Amenity AS Amenity
	ON RoomAmenity.AmenityId = Amenity.AmenityId
WHERE Amenity.Name = "Jacuzzi";

-- RESULTS
-- Yang, Karie	201	2023-03-06 - 2023-03-07
-- Seery, Bettyann	203	2023-02-05 - 2023-02-10
-- Yang, Karie	203	2023-09-13 - 2023-09-15
-- Burns, Michael	205	2023-06-28 - 2023-07-02
-- Vise, Wilfred	207	2023-04-23 - 2023-04-24
-- Holaway, Walter	301	2023-04-09 - 2023-04-13
-- Simmer, Mack	301	2023-11-22 - 2023-11-25
-- Seery, Bettyann	303	2023-07-28 - 2023-07-29
-- Cullison, Duane	305	2023-02-22 - 2023-02-24
-- Seery, Bettyann	305	2023-08-30 - 2023-09-01


-- 3. Write a query that returns all the rooms reserved for a specific guest, including the guest's name,
--  the room(s) reserved, the starting date of the reservation, and how many people were included in the reservation. (Choose a guest's name from the existing data.)

SELECT 
	concat(Guest.FirstName, ", ", Guest.LastName) as Guest,
    Reservation.RoomNumber,
    Reservation.StartDate,
    (Reservation.Adults + Reservation.Children) as TotalNumberOfPeople
    from Reservation as Reservation
    inner join Guest as Guest
	on Guest.GuestId = Reservation.GuestId
    where Guest.FirstName = "Michael"
    and Guest.LastName = "Burns";

-- RESULTS
-- Michael, Burns	307	2023-03-17	2
-- Michael, Burns	205	2023-06-28	2


-- 4. Write a query that returns a list of rooms, reservation ID, and per-room cost for each reservation. 
-- The results should include all rooms, whether or not there is a reservation associated with the room.

SELECT
Room.RoomNumber,
Reservation.ReservationId,
DATEDIFF(Reservation.EndDate, Reservation.StartDate) * (RoomType.Price +
IF(RoomType.RoomOccupancy < Reservation.adults, (Reservation.adults - RoomType.RoomOccupancy) * RoomType.ExtraPersonFee, 0)
) AS TotalReservationCost
from Room as Room
left outer join Reservation as reservation
on Reservation.RoomNumber = Room.RoomNumber
inner join RoomType as RoomType
on RoomType.RoomTypeId = Room.RoomTypeId;

-- RESULTS
-- 206 || 12 ||	599.96
-- 206 || 23 ||	449.97
-- 208 || 13 ||	599.96
-- 208 || 20 || 149.99
-- 306 || NULL || NULL		
-- 308 || 1	|| 299.98
-- 202 || 7 || 349.98
-- 204 || 16 ||	184.99
-- 302 || 6 ||	924.95
-- 302 || 25 || 699.96
-- 304 || 8 || 874.95
-- 304 || 14 || 184.99
-- 401 || 11 || 1199.97
-- 401 || 17 || 1259.97
-- 401 || 22 || 1199.97
-- 402 || NULL || NULL		
-- 205 || 15 || 699.96
-- 207 || 10 || 174.99
-- 305 || 3 || 349.98
-- 305 || 19 || 349.98
-- 307 || 5	|| 524.97
-- 201 || 4 || 199.99
-- 203 || 2 || 999.95
-- 203 || 21 || 399.98
-- 301 || 9 || 799.96
-- 301 || 24 || 599.97
-- 303 || 18 || 199.99


-- 5. Write a query that returns all the rooms accommodating at least three guests and that are reserved on any date in April 2023.

SELECT
RoomNumber
from Reservation
where (Adults + children) >= 3
and StartDate 
between "2023-04-01" and "2023-04-30";

-- RESULTS
-- There were no results returned for the question asked


-- 6. Write a query that returns a list of all guest names and the number of reservations per guest, sorted starting with the guest with the most reservations and then by the guest's last name.

SELECT
concat(Guest.FirstName, ", ", Guest.LastName) as Guest,
count(Reservation.ReservationId) as TotalGuestReservations
From Guest as Guest
left outer join Reservation as Reservation
on Reservation.GuestId = Guest.GuestId
group by Guest.GuestId
order by TotalGuestReservations,
Guest.LastName;

-- RESULTS
-- Zachery, Luechtefeld	1
-- Jeremiah, Pendergrass	1
-- Michael, Burns	2
-- Duane, Cullison	2
-- Walter, Holaway	2
-- Aurore, Lipton	2
-- Maritza, Tilton	2
-- Joleen, Tison	2
-- Wilfred, Vise	2
-- Karie, Yang	2
-- Bettyann, Seery	3
-- Mack, Simmer	4


-- 7. Write a query that displays the name, address, and phone number of a guest based on their phone number. (Choose a phone number from the existing data.)

SELECT 
concat(Guest.FirstName, ", ", Guest.LastName) as GuestName,
concat(Guest.Address, ", ", Guest.State, " ", Guest.ZipCode) as GuestAddress,
Guest.Phone
from Guest
where Guest.Phone = "1234567890";

-- RESULTS
-- Michael, Burns	123 Acorn St, NY 11111	1234567890