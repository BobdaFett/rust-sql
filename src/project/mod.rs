use postgres::Client;
use std::{fs::File, io::Write};

pub fn build_database(client: &mut Client) {
    // Create the new database.
    // I haven't even planned this one out yet.
    let create_user = "CREATE TABLE EMPLOYEE (
        UserID SERIAL NOT NULL,
        FirstName CHAR(32),
        LastName CHAR(32),
        Status CHAR(8) DEFAULT 'Active' 
            CHECK((Status = 'Active') OR (Status = 'Inactive')),
        DateActive DATE,
        DateInactive DATE,
        Department CHAR(32),
        PRIMARY KEY (UserID))";
    let create_warranty = "CREATE TABLE WARRANTY (
        WarrantyTypeID SERIAL PRIMARY KEY,
        YearsParts INT,
        YearsLabor INT,
        YearsService INT,
        WarrantyType VARCHAR(255))";
    let create_device = "CREATE TABLE DEVICE (
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
        FOREIGN KEY (UserID) REFERENCES EMPLOYEE(UserID))";
    let create_service = "CREATE TABLE SERVICE_RECORD (
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
        FOREIGN KEY (TechnicianID) REFERENCES EMPLOYEE(UserID))";
    let create_peripheral = "CREATE TABLE PERIPHERAL (
        PeripheralID SERIAL NOT NULL,
        PeripheralType CHAR(32),
        Price REAL,
        UserID INT,
        PRIMARY KEY (PeripheralId),
        FOREIGN KEY (UserID) REFERENCES EMPLOYEE(UserID))";
    
    // Create the database.
    // client.execute("CREATE DATABASE if not exists project", &[]).unwrap();
    
    // Create the tables.
    client
        .execute(create_user, &[])
        .expect("Failed to create user table");
    client
        .execute(create_warranty, &[])
        .expect("Failed to create warranty table");
    client
        .execute(create_device, &[])
        .expect("Failed to create device table");
    client
        .execute(create_service, &[])
        .expect("Failed to create service table");
    client
        .execute(create_peripheral, &[])
        .expect("Failed to create peripheral table");
}

#[allow(dead_code)]
pub fn insert_data(client: &mut Client) {
    // TODO Insert some random data here.
    // For now, maybe just create a single entry for each table.
    // "Consistency is the hobgoblin of small minds."
    // client.execute(person, &[]).unwrap();
    
    let home_dir = std::env::var("USERPROFILE").unwrap();

    // I have created files that contain a series of data insertion statements.
    // Read these files into the program and execute them.
    let insert_employee = std::fs::read_to_string(home_dir.clone() + "\\RustroverProjects\\rust-sql\\src\\project\\input\\EMPLOYEE.sql").expect("Could not read EMPLOYEE.sql");
    let insert_devices = std::fs::read_to_string(home_dir.clone() + "\\RustroverProjects\\rust-sql\\src\\project\\input\\DEVICE.sql").expect("Coult not read DEVICE.sql");
    let insert_warranty = std::fs::read_to_string(home_dir.clone() + "\\RustroverProjects\\rust-sql\\src\\project\\input\\WARRANTY.sql").expect("Could not read WARRANTY.sql");
    let insert_service = std::fs::read_to_string(home_dir.clone() + "\\RustroverProjects\\rust-sql\\src\\project\\input\\SERVICE_RECORD.sql").expect("Could not read SERVICE_RECORD.sql");
    let insert_peripheral = std::fs::read_to_string(home_dir.clone() + "\\RustroverProjects\\rust-sql\\src\\project\\input\\PERIPHERAL.sql").expect("Could not read PERIPHERAL.sql");

    // Execute the statements.
    // They already have \n and ; at the end, so we don't need to add them.
    client.batch_execute(insert_employee.as_str()).unwrap();
    client.batch_execute(insert_warranty.as_str()).unwrap();
    client.batch_execute(insert_devices.as_str()).unwrap();
    client.batch_execute(insert_service.as_str()).unwrap();
    client.batch_execute(insert_peripheral.as_str()).unwrap();
}

#[allow(dead_code)]
pub fn clear_database(client: &mut Client) {
    // Completely delete the database.
    let queries = "
        DROP TABLE IF EXISTS SERVICE_RECORD;
        DROP TABLE IF EXISTS DEVICE;
        DROP TABLE IF EXISTS WARRANTY;
        DROP TABLE IF EXISTS PERIPHERAL;
        DROP TABLE IF EXISTS EMPLOYEE CASCADE;
    ";

    client.batch_execute(queries).unwrap();
}

pub fn print_tables(client: &mut Client) {
    // Print the contents of the tables.
    let queries = "
        SELECT * FROM EMPLOYEE;
    ";

    for row in client.query(queries, &[]).unwrap() {
        println!("Employee: {} {} {} {} {} {} {}",
            row.get::<_, i32>(0),
            row.get::<_, String>(1),
            row.get::<_, String>(2),
            row.get::<_, String>(3),
            row.get::<_, String>(4),
            row.get::<_, String>(5),
            row.get::<_, String>(6));
    }

    for row in client.query("SELECT * FROM DEVICE", &[]).unwrap() {
        println!("Device: {} {} {} {} {} {} {} {} {} {} {} {}",
            row.get::<_, String>(0),
            row.get::<_, String>(1),
            row.get::<_, String>(2),
            row.get::<_, String>(3),
            row.get::<_, String>(4),
            row.get::<_, i32>(5),
            row.get::<_, String>(6),
            row.get::<_, String>(7),
            row.get::<_, i32>(8),
            row.get::<_, String>(9),
            row.get::<_, f32>(10),
            row.get::<_, i32>(11));
    }

    for row in client.query("SELECT * FROM WARRANTY", &[]).unwrap() {
        println!("Warranty: {} {} {} {} {}",
            row.get::<_, i32>(0),
            row.get::<_, i32>(1),
            row.get::<_, i32>(2),
            row.get::<_, i32>(3),
            row.get::<_, String>(4));
    }

    for row in client.query("SELECT * FROM SERVICE_RECORD", &[]).unwrap() {
        println!("Service Record: {} {} {} {} {} {} {} {}",
            row.get::<_, i32>(0),
            row.get::<_, String>(1),
            row.get::<_, String>(2),
            row.get::<_, String>(3),
            row.get::<_, f32>(4),
            row.get::<_, i32>(5),
            row.get::<_, String>(6),
            row.get::<_, i32>(7));
    }

    for row in client.query("SELECT * FROM PERIPHERAL", &[]).unwrap() {
        println!("Peripheral: {} {} {} {}",
            row.get::<_, i32>(0),
            row.get::<_, String>(1),
            row.get::<_, f32>(2),
            row.get::<_, i32>(3));
    }
}

#[allow(dead_code)]
pub fn query_one(client: &mut Client) {
    // Get the average amount of money that is required to start a new employee
    // in any given department (use 'Services' as an example)
    // This is the average of the sum of the price of all devices that are assigned
    // to people in the given department. This includes peripherals, such as mice and
    // monitors.
    let query = "
        SELECT AVG(D.Price + PE.Price)
        FROM DEVICE D, EMPLOYEE P, PERIPHERAL PE
        WHERE P.Department = 'Services' AND
            D.UserID = P.UserID AND
            PE.UserID = P.UserID
        GROUP BY P.UserID";

    for row in client.query(query, &[]).unwrap() {
        println!("Average cost of a device for a nurse: {}", row.get::<_, f32>(0));
    }
}

pub fn query_two(client: &mut Client) {
    // Get the average amount of money that is required to keep a given make/model
    // of device in service. This means the average amount of money that is spent
    // on repairs. This kind of data can be used to determine if a device is worth
    // keeping in service, and can allow for depreciation budgeting for that model.
    let query = "
        SELECT AVG(S.Price)
        FROM SERVICE_RECORD S, DEVICE D
        WHERE D.Brand = 'HP' AND
            D.Model = 'Elitebook 840 G9'";

    for row in client.query(query, &[]).unwrap() {
        println!("Average cost of repairs for an HP Elitebook 840 G3: {}", row.get::<_, f32>(0));
    }
}

pub fn query_three(client: &mut Client) {
    // Some third query that I haven't quite thought of yet.
}

#[cfg(test)]
mod testing {
    use postgres::{Client, NoTls};

    #[test]
    fn build_project() {
        // Make client.
        let mut client =
            Client::connect("host=localhost user=postgres password=IN$piron54286", NoTls).unwrap();

        // Run tests.
        super::clear_database(&mut client);
        super::build_database(&mut client);
        
        // Insert our fake data into the database.
        super::insert_data(&mut client);
    }

    #[test]
    fn project_interaction() {
        let mut client =
            Client::connect("host=localhost user=postgres password=IN$piron54286", NoTls).unwrap();

        // Clear and build the database.
        super::clear_database(&mut client);
        super::build_database(&mut client);

        // Ensure that there are no elements in the database.
        assert_eq!(client.query("SELECT * FROM EMPLOYEE", &[]).unwrap().len(), 0);

        // Run tests
        // Insert data.
        let person = "INSERT INTO EMPLOYEE (UserID, FirstName, LastName, Status, DateActive, DateInactive)
            VALUES (1, 'Lucas', 'Vas', 'Active', '11/15/2023', NULL)";

        let warranty = "INSERT INTO WARRANTY (WarrantyTypeID, YearsParts, YearsLabor, YearsService, WarrantyType)
            VALUES (1, 1, 1, 1, 'Basic')";

        let device = "INSERT INTO DEVICE (SerialNumber, Brand, Model, PurchaseDate, WarrantyDate, WarrantyTypeID, EndOfLifeDate, Status, OrderNumber, Seller, UserID, Type, Price)
            VALUES ('123456789', 'HP', 'Elitebook 840 G3', '11/15/2023', '11/15/2023', 1, '11/15/2023', 'Active', 1, 'HP', 1, 'Laptop', 1000.00)";

        let service = "INSERT INTO SERVICE_RECORD (ServiceDate, ServiceType, ServiceReason, TechnicianID, DeviceSerial, UserID, ServicePrice)
            VALUES ('11/15/2023', 'Repair', 'Broken Screen', 1, '123456789', 1, 100.00)";
        
        client.execute(person, &[]).unwrap();
        client.execute(warranty, &[]).unwrap();
        client.execute(device, &[]).unwrap();
        client.execute(service, &[]).unwrap();

        // Assertion tests - get data from the database and make sure it's correct.
        for row in client.query("SELECT FirstName, LastName FROM EMPLOYEE", &[]).expect("Failed to query person") {
            assert_eq!(row.get::<_, String>(0).trim(), "Lucas");
            assert_eq!(row.get::<_, String>(1).trim(), "Vas");
        }

        for row in client.query("SELECT Brand, Model, WarrantyTypeID, UserID, Price FROM DEVICE", &[]).expect("Failed to query device") {
            assert_eq!(row.get::<_, String>(0).trim(), "HP");
            assert_eq!(row.get::<_, String>(1).trim(), "Elitebook 840 G3");
            assert_eq!(row.get::<_, i32>(2), 1);
            assert_eq!(row.get::<_, i32>(3), 1);
            assert_eq!(row.get::<_, f32>(4), 1000.00);
        }

        for row in client.query("SELECT ServiceType, TechnicianID, DeviceSerial, ServicePrice FROM SERVICE_RECORD", &[]).expect("Failed to query service record") {
            assert_eq!(row.get::<_, String>(0).trim(), "Repair");
            assert_eq!(row.get::<_, i32>(1), 1);
            assert_eq!(row.get::<_, String>(2).trim(), "123456789");
            assert_eq!(row.get::<_, f32>(3), 100.00);
        }

        for row in client.query("SELECT WarrantyTypeID, YearsParts, YearsLabor, YearsService, WarrantyType FROM WARRANTY", &[]).expect("Failed to query warranty") {
            assert_eq!(row.get::<_, i32>(0), 1);
            assert_eq!(row.get::<_, i32>(1), 1);
            assert_eq!(row.get::<_, i32>(2), 1);
            assert_eq!(row.get::<_, i32>(3), 1);
            assert_eq!(row.get::<_, String>(4).trim(), "Basic");
        }
    }

    #[test]
    fn test_q1() {
        println!("Testing.");

        let mut client =
            Client::connect("host=localhost user=postgres password=IN$piron54286", NoTls).unwrap();

        super::clear_database(&mut client);
        super::build_database(&mut client);
        super::insert_data(&mut client);

        // We then want to test our queries.
        super::query_one(&mut client); // Unfortunately I don't know what the assertion should be.
        // super::query_two(&mut client);
        // super::query_three(&mut client);
    }
}
