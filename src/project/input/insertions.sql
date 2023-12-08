CREATE TABLE EMPLOYEE (
        UserID SERIAL NOT NULL,
        FirstName CHAR(32),
        LastName CHAR(32),
        Status CHAR(8) DEFAULT 'Active' 
            CHECK((Status = 'Active') OR (Status = 'Inactive')),
        DateActive DATE,
        DateInactive DATE,
        Department CHAR(32),
        PRIMARY KEY (UserID));

CREATE TABLE WARRANTY (
        WarrantyTypeID SERIAL PRIMARY KEY,
        YearsParts INT,
        YearsLabor INT,
        YearsService INT,
        WarrantyType VARCHAR(255));

CREATE TABLE DEVICE (
        SerialNumber CHAR(32) NOT NULL,
        Brand CHAR(32),
        Model CHAR(32),
        PurchaseDate DATE,
        WarrantyDate DATE,
        WarrantyTypeID INT,
        EndOfLifeDate DATE,
        Status CHAR(8) DEFAULT 'Active' 
            CHECK((Status = 'Active') OR (Status = 'Inactive')),
        OrderNumber INT,
        Seller CHAR(32),
        UserID INT,
        Type CHAR(32),
        Price REAL,
        PRIMARY KEY (SerialNumber),
        FOREIGN KEY (WarrantyTypeID) REFERENCES WARRANTY(WarrantyTypeID),
        FOREIGN KEY (UserID) REFERENCES EMPLOYEE(UserID));

CREATE TABLE SERVICE_RECORD (
        TicketID SERIAL NOT NULL,
        ServiceDate DATE,
        ServiceType VARCHAR(255),
        ServiceReason VARCHAR(255),
        Price REAL,
        TechnicianID INT,
        DeviceSerial CHAR(32),
        UserID INT,
        PRIMARY KEY (TicketID),
        FOREIGN KEY (UserID) REFERENCES EMPLOYEE(UserID),
        FOREIGN KEY (TechnicianID) REFERENCES EMPLOYEE(UserID));

CREATE TABLE PERIPHERAL (
        PeripheralID SERIAL NOT NULL,
        PeripheralType CHAR(32),
        Price REAL,
        UserID INT,
        PRIMARY KEY (PeripheralId),
        FOREIGN KEY (UserID) REFERENCES EMPLOYEE(UserID));


insert into EMPLOYEE (FirstName, LastName, Status, DateActive, DateInactive, department) values ('Buddie', 'McKew', 'Active', '6/30/2022', '4/8/2023', 'Services');
insert into EMPLOYEE (FirstName, LastName, Status, DateActive, DateInactive, department) values ('Don', 'Houtby', 'Active', '10/7/2023', '11/11/2020', 'Sales');
insert into EMPLOYEE (FirstName, LastName, Status, DateActive, DateInactive, department) values ('Nickolaus', 'Matuszewski', 'Inactive', '1/23/2023', '1/14/2022', 'Services');
insert into EMPLOYEE (FirstName, LastName, Status, DateActive, DateInactive, department) values ('Priscilla', 'Brownstein', 'Active', '6/14/2022', '4/1/2021', 'Product Management');
insert into EMPLOYEE (FirstName, LastName, Status, DateActive, DateInactive, department) values ('Raina', 'Glaves', 'Active', '10/29/2022', '2/26/2023', 'Support');
insert into EMPLOYEE (FirstName, LastName, Status, DateActive, DateInactive, department) values ('Cullen', 'Shirley', 'Inactive', '9/12/2022', '8/18/2023', 'Product Management');
insert into EMPLOYEE (FirstName, LastName, Status, DateActive, DateInactive, department) values ('Pollyanna', 'Andreucci', 'Inactive', '9/6/2023', '1/28/2022', 'Services');
insert into EMPLOYEE (FirstName, LastName, Status, DateActive, DateInactive, department) values ('Mufi', 'Cromblehome', 'Inactive', '10/7/2023', '7/18/2020', 'Services');
insert into EMPLOYEE (FirstName, LastName, Status, DateActive, DateInactive, department) values ('Imelda', 'Gloucester', 'Active', '10/18/2022', '3/1/2023', 'Support');
insert into EMPLOYEE (FirstName, LastName, Status, DateActive, DateInactive, department) values ('Frants', 'Pendrich', 'Active', '11/11/2022', '2/2/2023', 'Marketing');
insert into EMPLOYEE (FirstName, LastName, Status, DateActive, DateInactive, department) values ('Gabrila', 'McGuigan', 'Active', '8/5/2022', '10/19/2020', 'Support');
insert into EMPLOYEE (FirstName, LastName, Status, DateActive, DateInactive, department) values ('Laverne', 'Ryles', 'Active', '7/21/2023', '9/21/2021', 'Marketing');
insert into EMPLOYEE (FirstName, LastName, Status, DateActive, DateInactive, department) values ('Abbi', 'Garnsworthy', 'Inactive', '10/5/2023', '9/1/2021', 'Business Development');
insert into EMPLOYEE (FirstName, LastName, Status, DateActive, DateInactive, department) values ('Wrennie', 'Klyn', 'Active', '9/8/2023', '6/11/2022', 'Sales');
insert into EMPLOYEE (FirstName, LastName, Status, DateActive, DateInactive, department) values ('Genovera', 'Patel', 'Inactive', '11/8/2022', '8/2/2023', 'Human Resources');
insert into EMPLOYEE (FirstName, LastName, Status, DateActive, DateInactive, department) values ('Allister', 'Swinburne', 'Active', '7/27/2023', '9/24/2023', 'Business Development');
insert into EMPLOYEE (FirstName, LastName, Status, DateActive, DateInactive, department) values ('Almeta', 'Tofanini', 'Active', '11/23/2022', '12/12/2021', 'Business Development');
insert into EMPLOYEE (FirstName, LastName, Status, DateActive, DateInactive, department) values ('Bendix', 'Fibbings', 'Active', '10/9/2023', '10/27/2022', 'Business Development');
insert into EMPLOYEE (FirstName, LastName, Status, DateActive, DateInactive, department) values ('Rhys', 'Whitmell', 'Inactive', '4/17/2023', '6/16/2022', 'Sales');
insert into EMPLOYEE (FirstName, LastName, Status, DateActive, DateInactive, department) values ('Maggie', 'Denty', 'Active', '6/27/2023', '8/17/2023', 'Sales');
insert into EMPLOYEE (FirstName, LastName, Status, DateActive, DateInactive, department) values ('Shea', 'Audus', 'Active', '10/4/2023', '11/15/2023', 'Engineering');
insert into EMPLOYEE (FirstName, LastName, Status, DateActive, DateInactive, department) values ('Allin', 'Leall', 'Inactive', '10/8/2023', '5/8/2023', 'Product Management');
insert into EMPLOYEE (FirstName, LastName, Status, DateActive, DateInactive, department) values ('Richardo', 'Bonsul', 'Active', '10/27/2023', '8/19/2020', 'Support');
insert into EMPLOYEE (FirstName, LastName, Status, DateActive, DateInactive, department) values ('Bobby', 'Woofenden', 'Active', '4/6/2023', '8/3/2022', 'Support');
insert into EMPLOYEE (FirstName, LastName, Status, DateActive, DateInactive, department) values ('Twila', 'de Mendoza', 'Inactive', '12/26/2022', '10/1/2022', 'Business Development');
insert into EMPLOYEE (FirstName, LastName, Status, DateActive, DateInactive, department) values ('Gertrude', 'Splevings', 'Inactive', '2/2/2023', '9/24/2022', 'Product Management');
insert into EMPLOYEE (FirstName, LastName, Status, DateActive, DateInactive, department) values ('Otha', 'Tonkinson', 'Active', '3/8/2023', '4/1/2023', 'Support');
insert into EMPLOYEE (FirstName, LastName, Status, DateActive, DateInactive, department) values ('Mychal', 'Boynes', 'Active', '3/11/2023', '3/18/2022', 'Services');
insert into EMPLOYEE (FirstName, LastName, Status, DateActive, DateInactive, department) values ('Marena', 'Coppock.', 'Active', '6/4/2022', '6/8/2020', 'Accounting');
insert into EMPLOYEE (FirstName, LastName, Status, DateActive, DateInactive, department) values ('Jocelyn', 'Haldin', 'Inactive', '9/12/2023', '8/20/2023', 'Marketing');
insert into EMPLOYEE (FirstName, LastName, Status, DateActive, DateInactive, department) values ('Keely', 'MacKimmie', 'Active', '12/24/2022', '7/11/2020', 'Engineering');
insert into EMPLOYEE (FirstName, LastName, Status, DateActive, DateInactive, department) values ('Ana', 'Fliege', 'Inactive', '11/20/2022', '8/25/2023', 'Support');
insert into EMPLOYEE (FirstName, LastName, Status, DateActive, DateInactive, department) values ('Grayce', 'McKearnen', 'Inactive', '10/8/2022', '7/5/2022', 'Sales');
insert into EMPLOYEE (FirstName, LastName, Status, DateActive, DateInactive, department) values ('Lazaro', 'Taill', 'Inactive', '4/22/2023', '10/28/2023', 'Product Management');
insert into EMPLOYEE (FirstName, LastName, Status, DateActive, DateInactive, department) values ('Jacquelynn', 'Tinson', 'Active', '2/27/2023', '7/3/2020', 'Sales');
insert into EMPLOYEE (FirstName, LastName, Status, DateActive, DateInactive, department) values ('Tess', 'Greatrakes', 'Inactive', '4/25/2023', '7/7/2023', 'Training');
insert into EMPLOYEE (FirstName, LastName, Status, DateActive, DateInactive, department) values ('Nadya', 'Jeandot', 'Active', '7/23/2022', '8/20/2021', 'Support');
insert into EMPLOYEE (FirstName, LastName, Status, DateActive, DateInactive, department) values ('Murdoch', 'Bairstow', 'Active', '9/5/2023', '9/2/2023', 'Sales');
insert into EMPLOYEE (FirstName, LastName, Status, DateActive, DateInactive, department) values ('Findley', 'Middlemist', 'Inactive', '1/29/2023', '4/1/2022', 'Product Management');
insert into EMPLOYEE (FirstName, LastName, Status, DateActive, DateInactive, department) values ('Dale', 'Grinyov', 'Inactive', '1/28/2023', '5/25/2023', 'Research and Development');
insert into EMPLOYEE (FirstName, LastName, Status, DateActive, DateInactive, department) values ('Jelene', 'Corinton', 'Inactive', '7/5/2022', '2/19/2021', 'Legal');
insert into EMPLOYEE (FirstName, LastName, Status, DateActive, DateInactive, department) values ('Cynde', 'Osburn', 'Inactive', '10/25/2023', '4/25/2022', 'Training');
insert into EMPLOYEE (FirstName, LastName, Status, DateActive, DateInactive, department) values ('Elizabeth', 'Ryder', 'Active', '6/16/2022', '4/16/2022', 'Product Management');
insert into EMPLOYEE (FirstName, LastName, Status, DateActive, DateInactive, department) values ('Chico', 'Morratt', 'Inactive', '7/14/2022', '7/1/2023', 'Support');
insert into EMPLOYEE (FirstName, LastName, Status, DateActive, DateInactive, department) values ('Beatriz', 'Sartain', 'Active', '8/17/2023', '11/2/2020', 'Services');
insert into EMPLOYEE (FirstName, LastName, Status, DateActive, DateInactive, department) values ('Ania', 'Driussi', 'Active', '10/26/2023', '7/28/2023', 'Training');
insert into EMPLOYEE (FirstName, LastName, Status, DateActive, DateInactive, department) values ('Mead', 'Romanet', 'Active', '11/30/2023', '6/28/2023', 'Accounting');
insert into EMPLOYEE (FirstName, LastName, Status, DateActive, DateInactive, department) values ('Koral', 'Tunn', 'Active', '4/26/2023', '5/31/2023', 'Marketing');
insert into EMPLOYEE (FirstName, LastName, Status, DateActive, DateInactive, department) values ('Stuart', 'Maddison', 'Active', '6/27/2023', '10/12/2022', 'Marketing');
insert into EMPLOYEE (FirstName, LastName, Status, DateActive, DateInactive, department) values ('Scarface', 'Painter', 'Active', '8/6/2023', '1/25/2021', 'Research and Development');

insert into WARRANTY (YearsParts, YearsLabor, YearsService, WarrantyType) values (4, 2, 2, 'Comprehensive');
insert into WARRANTY (YearsParts, YearsLabor, YearsService, WarrantyType) values (2, 2, 4, 'Basic');
insert into WARRANTY (YearsParts, YearsLabor, YearsService, WarrantyType) values (3, 4, 10, 'Extended');
insert into WARRANTY (YearsParts, YearsLabor, YearsService, WarrantyType) values (6, 5, 9, 'Basic');
insert into WARRANTY (YearsParts, YearsLabor, YearsService, WarrantyType) values (2, 5, 6, 'Comprehensive');

insert into DEVICE (SerialNumber, Brand, Model, PurchaseDate, WarrantyDate, WarrantyTypeID, EndOfLifeDate, Status, OrderNumber, Seller, UserID, Type, Price) values (359703828, 'Lenovo', 'Elitebook 840 G3', '11/15/2023', '11/15/2023', 5, '11/15/2023', 'Inactive', 914327249, 'Lenovo', 41, 'Desktop', 3118.66);
insert into DEVICE (SerialNumber, Brand, Model, PurchaseDate, WarrantyDate, WarrantyTypeID, EndOfLifeDate, Status, OrderNumber, Seller, UserID, Type, Price) values (592991849, 'Apple', 'ZenBook UX305', '11/15/2023', '11/15/2023', 1, '11/15/2023', 'Inactive', 612137818, 'Dell', 30, 'Smartphone', 3199.11);
insert into DEVICE (SerialNumber, Brand, Model, PurchaseDate, WarrantyDate, WarrantyTypeID, EndOfLifeDate, Status, OrderNumber, Seller, UserID, Type, Price) values (478432741, 'Apple', 'Elitebook 840 G3', '11/15/2023', '11/15/2023', 5, '11/15/2023', 'Inactive', 117415523, 'Apple', 6, 'Smartphone', 6689.09);
insert into DEVICE (SerialNumber, Brand, Model, PurchaseDate, WarrantyDate, WarrantyTypeID, EndOfLifeDate, Status, OrderNumber, Seller, UserID, Type, Price) values (848828368, 'Lenovo', 'Latitude E7450', '11/15/2023', '11/15/2023', 1, '11/15/2023', 'Inactive', 340941884, 'HP', 35, 'Tablet', 9783.01);
insert into DEVICE (SerialNumber, Brand, Model, PurchaseDate, WarrantyDate, WarrantyTypeID, EndOfLifeDate, Status, OrderNumber, Seller, UserID, Type, Price) values (704804234, 'Dell', 'Elitebook 840 G3', '11/15/2023', '11/15/2023', 1, '11/15/2023', 'Inactive', 668463576, 'HP', 13, 'Desktop', 5776.18);
insert into DEVICE (SerialNumber, Brand, Model, PurchaseDate, WarrantyDate, WarrantyTypeID, EndOfLifeDate, Status, OrderNumber, Seller, UserID, Type, Price) values (64844694, 'Asus', 'Latitude E7450', '11/15/2023', '11/15/2023', 2, '11/15/2023', 'Inactive', 191006194, 'Dell', 37, 'Laptop', 7835.98);
insert into DEVICE (SerialNumber, Brand, Model, PurchaseDate, WarrantyDate, WarrantyTypeID, EndOfLifeDate, Status, OrderNumber, Seller, UserID, Type, Price) values (177294013, 'Apple', 'MacBook Pro', '11/15/2023', '11/15/2023', 4, '11/15/2023', 'Active', 569350858, 'HP', 28, 'Laptop', 632.82);
insert into DEVICE (SerialNumber, Brand, Model, PurchaseDate, WarrantyDate, WarrantyTypeID, EndOfLifeDate, Status, OrderNumber, Seller, UserID, Type, Price) values (191911427, 'Apple', 'MacBook Pro', '11/15/2023', '11/15/2023', 1, '11/15/2023', 'Inactive', 883549689, 'Apple', 12, 'Tablet', 439.43);
insert into DEVICE (SerialNumber, Brand, Model, PurchaseDate, WarrantyDate, WarrantyTypeID, EndOfLifeDate, Status, OrderNumber, Seller, UserID, Type, Price) values (240383147, 'Dell', 'ZenBook UX305', '11/15/2023', '11/15/2023', 3, '11/15/2023', 'Inactive', 51333652, 'Apple', 16, 'Tablet', 5232.77);
insert into DEVICE (SerialNumber, Brand, Model, PurchaseDate, WarrantyDate, WarrantyTypeID, EndOfLifeDate, Status, OrderNumber, Seller, UserID, Type, Price) values (45556216, 'Dell', 'MacBook Pro', '11/15/2023', '11/15/2023', 3, '11/15/2023', 'Active', 346074290, 'HP', 3, 'Tablet', 9205.05);
insert into DEVICE (SerialNumber, Brand, Model, PurchaseDate, WarrantyDate, WarrantyTypeID, EndOfLifeDate, Status, OrderNumber, Seller, UserID, Type, Price) values (436491803, 'Apple', 'ThinkPad T480', '11/15/2023', '11/15/2023', 3, '11/15/2023', 'Active', 694329828, 'Apple', 43, 'Server', 2311.41);
insert into DEVICE (SerialNumber, Brand, Model, PurchaseDate, WarrantyDate, WarrantyTypeID, EndOfLifeDate, Status, OrderNumber, Seller, UserID, Type, Price) values (15744000, 'Asus', 'ThinkPad T480', '11/15/2023', '11/15/2023', 4, '11/15/2023', 'Active', 470931274, 'Dell', 3, 'Tablet', 9775.84);
insert into DEVICE (SerialNumber, Brand, Model, PurchaseDate, WarrantyDate, WarrantyTypeID, EndOfLifeDate, Status, OrderNumber, Seller, UserID, Type, Price) values (814470735, 'Lenovo', 'Elitebook 840 G3', '11/15/2023', '11/15/2023', 3, '11/15/2023', 'Active', 751247172, 'Asus', 49, 'Tablet', 3266.48);
insert into DEVICE (SerialNumber, Brand, Model, PurchaseDate, WarrantyDate, WarrantyTypeID, EndOfLifeDate, Status, OrderNumber, Seller, UserID, Type, Price) values (641376511, 'Lenovo', 'MacBook Pro', '11/15/2023', '11/15/2023', 2, '11/15/2023', 'Inactive', 422510051, 'Apple', 8, 'Smartphone', 7187.95);
insert into DEVICE (SerialNumber, Brand, Model, PurchaseDate, WarrantyDate, WarrantyTypeID, EndOfLifeDate, Status, OrderNumber, Seller, UserID, Type, Price) values (923260106, 'Apple', 'ZenBook UX305', '11/15/2023', '11/15/2023', 1, '11/15/2023', 'Inactive', 942744346, 'Dell', 6, 'Server', 7964.81);
insert into DEVICE (SerialNumber, Brand, Model, PurchaseDate, WarrantyDate, WarrantyTypeID, EndOfLifeDate, Status, OrderNumber, Seller, UserID, Type, Price) values (277399164, 'Dell', 'MacBook Pro', '11/15/2023', '11/15/2023', 4, '11/15/2023', 'Active', 211159399, 'Asus', 29, 'Desktop', 2745.36);
insert into DEVICE (SerialNumber, Brand, Model, PurchaseDate, WarrantyDate, WarrantyTypeID, EndOfLifeDate, Status, OrderNumber, Seller, UserID, Type, Price) values (430349646, 'Asus', 'ThinkPad T480', '11/15/2023', '11/15/2023', 4, '11/15/2023', 'Inactive', 86624134, 'Asus', 33, 'Desktop', 3551.16);
insert into DEVICE (SerialNumber, Brand, Model, PurchaseDate, WarrantyDate, WarrantyTypeID, EndOfLifeDate, Status, OrderNumber, Seller, UserID, Type, Price) values (710876985, 'Lenovo', 'Elitebook 840 G3', '11/15/2023', '11/15/2023', 2, '11/15/2023', 'Active', 188897414, 'Asus', 22, 'Laptop', 1506.0);
insert into DEVICE (SerialNumber, Brand, Model, PurchaseDate, WarrantyDate, WarrantyTypeID, EndOfLifeDate, Status, OrderNumber, Seller, UserID, Type, Price) values (405343850, 'Lenovo', 'Elitebook 840 G3', '11/15/2023', '11/15/2023', 5, '11/15/2023', 'Inactive', 194802104, 'HP', 37, 'Server', 2714.98);
insert into DEVICE (SerialNumber, Brand, Model, PurchaseDate, WarrantyDate, WarrantyTypeID, EndOfLifeDate, Status, OrderNumber, Seller, UserID, Type, Price) values (694014244, 'HP', 'MacBook Pro', '11/15/2023', '11/15/2023', 2, '11/15/2023', 'Inactive', 762596756, 'Apple', 12, 'Desktop', 8143.65);
insert into DEVICE (SerialNumber, Brand, Model, PurchaseDate, WarrantyDate, WarrantyTypeID, EndOfLifeDate, Status, OrderNumber, Seller, UserID, Type, Price) values (834223476, 'Dell', 'Latitude E7450', '11/15/2023', '11/15/2023', 1, '11/15/2023', 'Active', 415875533, 'HP', 49, 'Smartphone', 354.93);
insert into DEVICE (SerialNumber, Brand, Model, PurchaseDate, WarrantyDate, WarrantyTypeID, EndOfLifeDate, Status, OrderNumber, Seller, UserID, Type, Price) values (228596271, 'Lenovo', 'MacBook Pro', '11/15/2023', '11/15/2023', 1, '11/15/2023', 'Inactive', 496192657, 'Apple', 40, 'Laptop', 502.39);
insert into DEVICE (SerialNumber, Brand, Model, PurchaseDate, WarrantyDate, WarrantyTypeID, EndOfLifeDate, Status, OrderNumber, Seller, UserID, Type, Price) values (899010219, 'Apple', 'ZenBook UX305', '11/15/2023', '11/15/2023', 2, '11/15/2023', 'Active', 69006023, 'HP', 3, 'Smartphone', 7308.34);
insert into DEVICE (SerialNumber, Brand, Model, PurchaseDate, WarrantyDate, WarrantyTypeID, EndOfLifeDate, Status, OrderNumber, Seller, UserID, Type, Price) values (127461071, 'Asus', 'MacBook Pro', '11/15/2023', '11/15/2023', 3, '11/15/2023', 'Inactive', 557126199, 'Dell', 44, 'Laptop', 8604.23);
insert into DEVICE (SerialNumber, Brand, Model, PurchaseDate, WarrantyDate, WarrantyTypeID, EndOfLifeDate, Status, OrderNumber, Seller, UserID, Type, Price) values (867835324, 'HP', 'MacBook Pro', '11/15/2023', '11/15/2023', 4, '11/15/2023', 'Inactive', 450465003, 'Dell', 21, 'Desktop', 5300.51);
insert into DEVICE (SerialNumber, Brand, Model, PurchaseDate, WarrantyDate, WarrantyTypeID, EndOfLifeDate, Status, OrderNumber, Seller, UserID, Type, Price) values (271544877, 'Apple', 'Latitude E7450', '11/15/2023', '11/15/2023', 2, '11/15/2023', 'Active', 521338677, 'Apple', 24, 'Tablet', 545.02);
insert into DEVICE (SerialNumber, Brand, Model, PurchaseDate, WarrantyDate, WarrantyTypeID, EndOfLifeDate, Status, OrderNumber, Seller, UserID, Type, Price) values (394765696, 'Asus', 'MacBook Pro', '11/15/2023', '11/15/2023', 4, '11/15/2023', 'Inactive', 444433982, 'Apple', 3, 'Server', 2593.78);
insert into DEVICE (SerialNumber, Brand, Model, PurchaseDate, WarrantyDate, WarrantyTypeID, EndOfLifeDate, Status, OrderNumber, Seller, UserID, Type, Price) values (585186132, 'HP', 'MacBook Pro', '11/15/2023', '11/15/2023', 4, '11/15/2023', 'Active', 11708574, 'Dell', 8, 'Desktop', 3118.01);
insert into DEVICE (SerialNumber, Brand, Model, PurchaseDate, WarrantyDate, WarrantyTypeID, EndOfLifeDate, Status, OrderNumber, Seller, UserID, Type, Price) values (660427103, 'Dell', 'Elitebook 840 G3', '11/15/2023', '11/15/2023', 1, '11/15/2023', 'Active', 171033952, 'Apple', 13, 'Laptop', 2232.49);
insert into DEVICE (SerialNumber, Brand, Model, PurchaseDate, WarrantyDate, WarrantyTypeID, EndOfLifeDate, Status, OrderNumber, Seller, UserID, Type, Price) values (535232351, 'Dell', 'Elitebook 840 G3', '11/15/2023', '11/15/2023', 1, '11/15/2023', 'Inactive', 377465957, 'HP', 40, 'Desktop', 914.74);
insert into DEVICE (SerialNumber, Brand, Model, PurchaseDate, WarrantyDate, WarrantyTypeID, EndOfLifeDate, Status, OrderNumber, Seller, UserID, Type, Price) values (86708076, 'HP', 'Elitebook 840 G3', '11/15/2023', '11/15/2023', 3, '11/15/2023', 'Active', 820544754, 'HP', 26, 'Tablet', 4874.99);
insert into DEVICE (SerialNumber, Brand, Model, PurchaseDate, WarrantyDate, WarrantyTypeID, EndOfLifeDate, Status, OrderNumber, Seller, UserID, Type, Price) values (116601658, 'Dell', 'ZenBook UX305', '11/15/2023', '11/15/2023', 3, '11/15/2023', 'Inactive', 456210271, 'Dell', 49, 'Tablet', 1402.42);
insert into DEVICE (SerialNumber, Brand, Model, PurchaseDate, WarrantyDate, WarrantyTypeID, EndOfLifeDate, Status, OrderNumber, Seller, UserID, Type, Price) values (516365677, 'Dell', 'MacBook Pro', '11/15/2023', '11/15/2023', 3, '11/15/2023', 'Inactive', 403663748, 'Asus', 37, 'Smartphone', 3761.8);
insert into DEVICE (SerialNumber, Brand, Model, PurchaseDate, WarrantyDate, WarrantyTypeID, EndOfLifeDate, Status, OrderNumber, Seller, UserID, Type, Price) values (508210435, 'Apple', 'MacBook Pro', '11/15/2023', '11/15/2023', 5, '11/15/2023', 'Inactive', 2467201, 'Apple', 45, 'Server', 3591.98);
insert into DEVICE (SerialNumber, Brand, Model, PurchaseDate, WarrantyDate, WarrantyTypeID, EndOfLifeDate, Status, OrderNumber, Seller, UserID, Type, Price) values (614529619, 'Dell', 'ZenBook UX305', '11/15/2023', '11/15/2023', 1, '11/15/2023', 'Active', 692819042, 'Apple', 4, 'Server', 8831.6);
insert into DEVICE (SerialNumber, Brand, Model, PurchaseDate, WarrantyDate, WarrantyTypeID, EndOfLifeDate, Status, OrderNumber, Seller, UserID, Type, Price) values (639457200, 'Apple', 'MacBook Pro', '11/15/2023', '11/15/2023', 5, '11/15/2023', 'Inactive', 630047296, 'Asus', 40, 'Laptop', 113.59);
insert into DEVICE (SerialNumber, Brand, Model, PurchaseDate, WarrantyDate, WarrantyTypeID, EndOfLifeDate, Status, OrderNumber, Seller, UserID, Type, Price) values (273507974, 'Lenovo', 'ThinkPad T480', '11/15/2023', '11/15/2023', 1, '11/15/2023', 'Inactive', 308690793, 'HP', 50, 'Smartphone', 5163.01);
insert into DEVICE (SerialNumber, Brand, Model, PurchaseDate, WarrantyDate, WarrantyTypeID, EndOfLifeDate, Status, OrderNumber, Seller, UserID, Type, Price) values (484116905, 'Lenovo', 'Elitebook 840 G3', '11/15/2023', '11/15/2023', 4, '11/15/2023', 'Inactive', 873514322, 'Lenovo', 28, 'Server', 3956.71);
insert into DEVICE (SerialNumber, Brand, Model, PurchaseDate, WarrantyDate, WarrantyTypeID, EndOfLifeDate, Status, OrderNumber, Seller, UserID, Type, Price) values (199374043, 'Dell', 'MacBook Pro', '11/15/2023', '11/15/2023', 5, '11/15/2023', 'Inactive', 483390784, 'Apple', 41, 'Tablet', 1697.25);
insert into DEVICE (SerialNumber, Brand, Model, PurchaseDate, WarrantyDate, WarrantyTypeID, EndOfLifeDate, Status, OrderNumber, Seller, UserID, Type, Price) values (498448660, 'Dell', 'MacBook Pro', '11/15/2023', '11/15/2023', 1, '11/15/2023', 'Inactive', 674196558, 'HP', 24, 'Server', 9097.15);
insert into DEVICE (SerialNumber, Brand, Model, PurchaseDate, WarrantyDate, WarrantyTypeID, EndOfLifeDate, Status, OrderNumber, Seller, UserID, Type, Price) values (677360405, 'HP', 'MacBook Pro', '11/15/2023', '11/15/2023', 4, '11/15/2023', 'Active', 790576540, 'HP', 26, 'Server', 7409.52);
insert into DEVICE (SerialNumber, Brand, Model, PurchaseDate, WarrantyDate, WarrantyTypeID, EndOfLifeDate, Status, OrderNumber, Seller, UserID, Type, Price) values (241537302, 'Dell', 'MacBook Pro', '11/15/2023', '11/15/2023', 5, '11/15/2023', 'Active', 911191975, 'Apple', 16, 'Smartphone', 9512.49);
insert into DEVICE (SerialNumber, Brand, Model, PurchaseDate, WarrantyDate, WarrantyTypeID, EndOfLifeDate, Status, OrderNumber, Seller, UserID, Type, Price) values (554997139, 'Lenovo', 'ThinkPad T480', '11/15/2023', '11/15/2023', 5, '11/15/2023', 'Inactive', 425833157, 'Apple', 31, 'Server', 5684.29);
insert into DEVICE (SerialNumber, Brand, Model, PurchaseDate, WarrantyDate, WarrantyTypeID, EndOfLifeDate, Status, OrderNumber, Seller, UserID, Type, Price) values (899596378, 'HP', 'ThinkPad T480', '11/15/2023', '11/15/2023', 3, '11/15/2023', 'Inactive', 439536056, 'Dell', 21, 'Server', 2544.24);
insert into DEVICE (SerialNumber, Brand, Model, PurchaseDate, WarrantyDate, WarrantyTypeID, EndOfLifeDate, Status, OrderNumber, Seller, UserID, Type, Price) values (132248263, 'Dell', 'MacBook Pro', '11/15/2023', '11/15/2023', 2, '11/15/2023', 'Inactive', 127370444, 'Lenovo', 4, 'Laptop', 4718.89);
insert into DEVICE (SerialNumber, Brand, Model, PurchaseDate, WarrantyDate, WarrantyTypeID, EndOfLifeDate, Status, OrderNumber, Seller, UserID, Type, Price) values (370233108, 'Lenovo', 'MacBook Pro', '11/15/2023', '11/15/2023', 2, '11/15/2023', 'Active', 739524463, 'Apple', 18, 'Laptop', 2225.04);
insert into DEVICE (SerialNumber, Brand, Model, PurchaseDate, WarrantyDate, WarrantyTypeID, EndOfLifeDate, Status, OrderNumber, Seller, UserID, Type, Price) values (43982421, 'Apple', 'Latitude E7450', '11/15/2023', '11/15/2023', 5, '11/15/2023', 'Inactive', 195836015, 'Apple', 3, 'Tablet', 8321.15);
insert into DEVICE (SerialNumber, Brand, Model, PurchaseDate, WarrantyDate, WarrantyTypeID, EndOfLifeDate, Status, OrderNumber, Seller, UserID, Type, Price) values (69483408, 'HP', 'ZenBook UX305', '11/15/2023', '11/15/2023', 1, '11/15/2023', 'Active', 2801810, 'Dell', 28, 'Laptop', 5179.69);
insert into DEVICE (SerialNumber, Brand, Model, PurchaseDate, WarrantyDate, WarrantyTypeID, EndOfLifeDate, Status, OrderNumber, Seller, UserID, Type, Price) values (416115217, 'Lenovo', 'MacBook Pro', '11/15/2023', '11/15/2023', 1, '11/15/2023', 'Inactive', 550415222, 'Asus', 30, 'Smartphone', 2966.27);
insert into DEVICE (SerialNumber, Brand, Model, PurchaseDate, WarrantyDate, WarrantyTypeID, EndOfLifeDate, Status, OrderNumber, Seller, UserID, Type, Price) values (383681003, 'HP', 'ZenBook UX305', '11/15/2023', '11/15/2023', 5, '11/15/2023', 'Active', 762295994, 'Asus', 45, 'Tablet', 9007.69);

insert into PERIPHERAL (PeripheralType, Price, UserID) values ('Monitor', 679.66, 5);
insert into PERIPHERAL (PeripheralType, Price, UserID) values ('Scanner', 574.64, 14);
insert into PERIPHERAL (PeripheralType, Price, UserID) values ('Scanner', 781.13, 5);
insert into PERIPHERAL (PeripheralType, Price, UserID) values ('Monitor', 610.34, 42);
insert into PERIPHERAL (PeripheralType, Price, UserID) values ('Mouse', 502.69, 5);
insert into PERIPHERAL (PeripheralType, Price, UserID) values ('Keyboard', 754.08, 15);
insert into PERIPHERAL (PeripheralType, Price, UserID) values ('Scanner', 703.2, 30);
insert into PERIPHERAL (PeripheralType, Price, UserID) values ('Printer', 911.04, 27);
insert into PERIPHERAL (PeripheralType, Price, UserID) values ('Printer', 954.6, 20);
insert into PERIPHERAL (PeripheralType, Price, UserID) values ('Mouse', 254.95, 48);
insert into PERIPHERAL (PeripheralType, Price, UserID) values ('Scanner', 509.01, 47);
insert into PERIPHERAL (PeripheralType, Price, UserID) values ('Monitor', 745.4, 33);
insert into PERIPHERAL (PeripheralType, Price, UserID) values ('Printer', 995.78, 30);
insert into PERIPHERAL (PeripheralType, Price, UserID) values ('Scanner', 496.92, 32);
insert into PERIPHERAL (PeripheralType, Price, UserID) values ('Monitor', 640.26, 47);
insert into PERIPHERAL (PeripheralType, Price, UserID) values ('Mouse', 708.94, 12);
insert into PERIPHERAL (PeripheralType, Price, UserID) values ('Keyboard', 842.83, 16);
insert into PERIPHERAL (PeripheralType, Price, UserID) values ('Printer', 368.92, 25);
insert into PERIPHERAL (PeripheralType, Price, UserID) values ('Keyboard', 480.05, 17);
insert into PERIPHERAL (PeripheralType, Price, UserID) values ('Mouse', 174.08, 18);
insert into PERIPHERAL (PeripheralType, Price, UserID) values ('Printer', 168.47, 6);
insert into PERIPHERAL (PeripheralType, Price, UserID) values ('Keyboard', 479.74, 14);
insert into PERIPHERAL (PeripheralType, Price, UserID) values ('Mouse', 359.67, 37);
insert into PERIPHERAL (PeripheralType, Price, UserID) values ('Monitor', 36.95, 40);
insert into PERIPHERAL (PeripheralType, Price, UserID) values ('Scanner', 763.04, 14);

insert into SERVICE_RECORD (ServiceDate, ServiceType, ServiceReason, TechnicianID, DeviceSerial, UserID, Price) values ('1/17/1991', 'Installation', 'Battery Replacement', 12, 980222766, 15, 143.14);
insert into SERVICE_RECORD (ServiceDate, ServiceType, ServiceReason, TechnicianID, DeviceSerial, UserID, Price) values ('11/30/1997', 'Upgrade', 'Battery Replacement', 30, 307132185, 4, 60.29);
insert into SERVICE_RECORD (ServiceDate, ServiceType, ServiceReason, TechnicianID, DeviceSerial, UserID, Price) values ('7/6/2007', 'Installation', 'Broken Screen', 32, 463477682, 17, 775.2);
insert into SERVICE_RECORD (ServiceDate, ServiceType, ServiceReason, TechnicianID, DeviceSerial, UserID, Price) values ('1/3/2008', 'Repair', 'Battery Replacement', 39, 297917385, 11, 289.47);
insert into SERVICE_RECORD (ServiceDate, ServiceType, ServiceReason, TechnicianID, DeviceSerial, UserID, Price) values ('12/1/2021', 'Upgrade', 'Broken Screen', 41, 393693963, 20, 36.85);
insert into SERVICE_RECORD (ServiceDate, ServiceType, ServiceReason, TechnicianID, DeviceSerial, UserID, Price) values ('5/18/1996', 'Repair', 'Broken Screen', 38, 126903278, 15, 592.86);
insert into SERVICE_RECORD (ServiceDate, ServiceType, ServiceReason, TechnicianID, DeviceSerial, UserID, Price) values ('6/18/1998', 'Repair', 'Broken Screen', 39, 808318954, 11, 227.26);
insert into SERVICE_RECORD (ServiceDate, ServiceType, ServiceReason, TechnicianID, DeviceSerial, UserID, Price) values ('9/20/1998', 'Upgrade', 'Software Issue', 18, 905948651, 1, 174.07);
insert into SERVICE_RECORD (ServiceDate, ServiceType, ServiceReason, TechnicianID, DeviceSerial, UserID, Price) values ('7/26/2000', 'Repair', 'Hardware Issue', 16, 990827366, 5, 390.78);
insert into SERVICE_RECORD (ServiceDate, ServiceType, ServiceReason, TechnicianID, DeviceSerial, UserID, Price) values ('3/19/2023', 'Maintenance', 'Broken Screen', 4, 564932526, 9, 696.61);
insert into SERVICE_RECORD (ServiceDate, ServiceType, ServiceReason, TechnicianID, DeviceSerial, UserID, Price) values ('7/14/2010', 'Upgrade', 'Battery Replacement', 48, 985182488, 6, 64.56);
insert into SERVICE_RECORD (ServiceDate, ServiceType, ServiceReason, TechnicianID, DeviceSerial, UserID, Price) values ('11/15/2000', 'Installation', 'Broken Screen', 20, 112969490, 31, 331.25);
insert into SERVICE_RECORD (ServiceDate, ServiceType, ServiceReason, TechnicianID, DeviceSerial, UserID, Price) values ('10/12/2014', 'Installation', 'Battery Replacement', 30, 473478153, 35, 767.58);
insert into SERVICE_RECORD (ServiceDate, ServiceType, ServiceReason, TechnicianID, DeviceSerial, UserID, Price) values ('11/29/2002', 'Upgrade', 'Broken Screen', 6, 253747239, 12, 241.41);
insert into SERVICE_RECORD (ServiceDate, ServiceType, ServiceReason, TechnicianID, DeviceSerial, UserID, Price) values ('10/15/2001', 'Repair', 'Broken Screen', 19, 557700912, 23, 171.77);
insert into SERVICE_RECORD (ServiceDate, ServiceType, ServiceReason, TechnicianID, DeviceSerial, UserID, Price) values ('9/16/2020', 'Upgrade', 'Broken Screen', 5, 948108873, 1, 369.78);
insert into SERVICE_RECORD (ServiceDate, ServiceType, ServiceReason, TechnicianID, DeviceSerial, UserID, Price) values ('11/28/2017', 'Upgrade', 'Battery Replacement', 9, 973822826, 28, 902.26);
insert into SERVICE_RECORD (ServiceDate, ServiceType, ServiceReason, TechnicianID, DeviceSerial, UserID, Price) values ('3/15/2008', 'Upgrade', 'Broken Screen', 18, 542238436, 33, 684.51);
insert into SERVICE_RECORD (ServiceDate, ServiceType, ServiceReason, TechnicianID, DeviceSerial, UserID, Price) values ('1/26/1991', 'Maintenance', 'Software Issue', 8, 349555731, 4, 788.19);
insert into SERVICE_RECORD (ServiceDate, ServiceType, ServiceReason, TechnicianID, DeviceSerial, UserID, Price) values ('3/1/2004', 'Upgrade', 'Software Issue', 39, 753560445, 17, 695.8);
insert into SERVICE_RECORD (ServiceDate, ServiceType, ServiceReason, TechnicianID, DeviceSerial, UserID, Price) values ('8/16/1992', 'Upgrade', 'Hardware Issue', 27, 707647565, 21, 691.88);
insert into SERVICE_RECORD (ServiceDate, ServiceType, ServiceReason, TechnicianID, DeviceSerial, UserID, Price) values ('6/17/2017', 'Upgrade', 'Hardware Issue', 36, 172027300, 28, 160.02);
insert into SERVICE_RECORD (ServiceDate, ServiceType, ServiceReason, TechnicianID, DeviceSerial, UserID, Price) values ('7/19/2015', 'Repair', 'Battery Replacement', 25, 717192590, 38, 120.38);
insert into SERVICE_RECORD (ServiceDate, ServiceType, ServiceReason, TechnicianID, DeviceSerial, UserID, Price) values ('10/28/1993', 'Installation', 'Hardware Issue', 28, 114159978, 8, 758.14);
insert into SERVICE_RECORD (ServiceDate, ServiceType, ServiceReason, TechnicianID, DeviceSerial, UserID, Price) values ('1/21/2002', 'Repair', 'Battery Replacement', 38, 722681657, 28, 838.74);
insert into SERVICE_RECORD (ServiceDate, ServiceType, ServiceReason, TechnicianID, DeviceSerial, UserID, Price) values ('12/2/1997', 'Upgrade', 'Broken Screen', 16, 736372081, 31, 519.58);
insert into SERVICE_RECORD (ServiceDate, ServiceType, ServiceReason, TechnicianID, DeviceSerial, UserID, Price) values ('3/7/1991', 'Upgrade', 'Broken Screen', 42, 707014019, 41, 736.14);
insert into SERVICE_RECORD (ServiceDate, ServiceType, ServiceReason, TechnicianID, DeviceSerial, UserID, Price) values ('11/3/2008', 'Repair', 'Software Issue', 20, 940877031, 39, 673.59);
insert into SERVICE_RECORD (ServiceDate, ServiceType, ServiceReason, TechnicianID, DeviceSerial, UserID, Price) values ('1/18/2002', 'Installation', 'Software Issue', 7, 248143175, 49, 383.73);
insert into SERVICE_RECORD (ServiceDate, ServiceType, ServiceReason, TechnicianID, DeviceSerial, UserID, Price) values ('1/6/1992', 'Repair', 'Battery Replacement', 44, 417495776, 27, 850.14);
insert into SERVICE_RECORD (ServiceDate, ServiceType, ServiceReason, TechnicianID, DeviceSerial, UserID, Price) values ('4/17/2000', 'Repair', 'Hardware Issue', 50, 660728323, 25, 844.73);
insert into SERVICE_RECORD (ServiceDate, ServiceType, ServiceReason, TechnicianID, DeviceSerial, UserID, Price) values ('11/13/2022', 'Upgrade', 'Broken Screen', 21, 884199736, 21, 737.58);
insert into SERVICE_RECORD (ServiceDate, ServiceType, ServiceReason, TechnicianID, DeviceSerial, UserID, Price) values ('4/17/2022', 'Repair', 'Hardware Issue', 22, 427991508, 26, 798.41);
insert into SERVICE_RECORD (ServiceDate, ServiceType, ServiceReason, TechnicianID, DeviceSerial, UserID, Price) values ('10/25/2000', 'Maintenance', 'Battery Replacement', 49, 104853874, 15, 750.66);
insert into SERVICE_RECORD (ServiceDate, ServiceType, ServiceReason, TechnicianID, DeviceSerial, UserID, Price) values ('12/3/1999', 'Upgrade', 'Broken Screen', 45, 385686534, 40, 627.59);
insert into SERVICE_RECORD (ServiceDate, ServiceType, ServiceReason, TechnicianID, DeviceSerial, UserID, Price) values ('1/30/2007', 'Repair', 'Battery Replacement', 7, 382414938, 19, 504.77);
insert into SERVICE_RECORD (ServiceDate, ServiceType, ServiceReason, TechnicianID, DeviceSerial, UserID, Price) values ('5/16/1995', 'Maintenance', 'Broken Screen', 46, 532738214, 29, 75.91);
insert into SERVICE_RECORD (ServiceDate, ServiceType, ServiceReason, TechnicianID, DeviceSerial, UserID, Price) values ('12/14/2012', 'Repair', 'Software Issue', 40, 385557851, 30, 861.54);
insert into SERVICE_RECORD (ServiceDate, ServiceType, ServiceReason, TechnicianID, DeviceSerial, UserID, Price) values ('2/18/2009', 'Upgrade', 'Software Issue', 11, 118986050, 19, 171.64);
insert into SERVICE_RECORD (ServiceDate, ServiceType, ServiceReason, TechnicianID, DeviceSerial, UserID, Price) values ('1/16/2003', 'Upgrade', 'Hardware Issue', 19, 758684628, 28, 264.88);
insert into SERVICE_RECORD (ServiceDate, ServiceType, ServiceReason, TechnicianID, DeviceSerial, UserID, Price) values ('4/16/2014', 'Installation', 'Battery Replacement', 10, 787459738, 24, 4.84);
insert into SERVICE_RECORD (ServiceDate, ServiceType, ServiceReason, TechnicianID, DeviceSerial, UserID, Price) values ('10/11/1995', 'Repair', 'Hardware Issue', 21, 294094002, 23, 557.15);
insert into SERVICE_RECORD (ServiceDate, ServiceType, ServiceReason, TechnicianID, DeviceSerial, UserID, Price) values ('7/29/2016', 'Installation', 'Software Issue', 48, 783134333, 17, 983.64);
insert into SERVICE_RECORD (ServiceDate, ServiceType, ServiceReason, TechnicianID, DeviceSerial, UserID, Price) values ('5/16/2003', 'Upgrade', 'Battery Replacement', 18, 934153226, 33, 294.28);
insert into SERVICE_RECORD (ServiceDate, ServiceType, ServiceReason, TechnicianID, DeviceSerial, UserID, Price) values ('3/14/2004', 'Upgrade', 'Broken Screen', 20, 893404858, 29, 76.51);
insert into SERVICE_RECORD (ServiceDate, ServiceType, ServiceReason, TechnicianID, DeviceSerial, UserID, Price) values ('8/14/2004', 'Installation', 'Software Issue', 17, 609950603, 13, 651.48);
insert into SERVICE_RECORD (ServiceDate, ServiceType, ServiceReason, TechnicianID, DeviceSerial, UserID, Price) values ('4/19/2001', 'Maintenance', 'Battery Replacement', 27, 294339219, 3, 930.67);
insert into SERVICE_RECORD (ServiceDate, ServiceType, ServiceReason, TechnicianID, DeviceSerial, UserID, Price) values ('8/12/2007', 'Maintenance', 'Software Issue', 36, 717739788, 19, 30.41);
insert into SERVICE_RECORD (ServiceDate, ServiceType, ServiceReason, TechnicianID, DeviceSerial, UserID, Price) values ('12/16/2015', 'Repair', 'Hardware Issue', 4, 806776506, 44, 23.89);
insert into SERVICE_RECORD (ServiceDate, ServiceType, ServiceReason, TechnicianID, DeviceSerial, UserID, Price) values ('3/5/2013', 'Installation', 'Hardware Issue', 2, 654181539, 26, 825.82);
