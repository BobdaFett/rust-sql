use postgres::Client;

pub fn build_database(client: &mut Client) {
    // Create the new database.
    // I haven't even planned this one out yet.
    let create_user = "CREATE TABLE IF NOT EXISTS PERSON (
        UserID INT NOT NULL,
        FirstName CHAR(32),
        LastName CHAR(32),
        Status CHAR(8) DEFAULT 'Active' 
            CHECK((Status = 'Active') OR (Status = 'Inactive')),
        DateActive DATE,
        DateInactive DATE,
        PRIMARY KEY (UserID))";
    let create_warranty = "CREATE TABLE IF NOT EXISTS WARRANTY (
        WarrantyTypeID INT PRIMARY KEY,
        YearsParts INT,
        YearsLabor INT,
        YearsService INT,
        WarrantyType VARCHAR(255))";
    let create_device = "CREATE TABLE IF NOT EXISTS DEVICE (
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
        PRIMARY KEY (SerialNumber),
        FOREIGN KEY (WarrantyTypeID) REFERENCES WARRANTY(WarrantyTypeID),
        FOREIGN KEY (UserID) REFERENCES PERSON(UserID))";
    let create_service = "CREATE TABLE IF NOT EXISTS SERVICE_RECORD (
        TicketID SERIAL NOT NULL,
        ServiceDate DATE,
        ServiceType VARCHAR(255),
        ServiceReason VARCHAR(255),
        TechnicianID INT,
        DeviceSerial CHAR(32),
        UserID INT,
        PRIMARY KEY (TicketID),
        FOREIGN KEY (UserID) REFERENCES PERSON(UserID),
        FOREIGN KEY (TechnicianID) REFERENCES PERSON(UserID))";

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
}

#[allow(dead_code)]
pub fn insert_data(client: &mut Client) {
    // TODO Insert some random data here.
    // For now, maybe just create a single entry for each table.
    // "Consistency is the hobgoblin of small minds."
    let person =
        "INSERT INTO PERSON (UserID, FirstName, LastName, Status, DateActive, DateInactive)
        VALUES (1, 'Lucas', 'Vas', 'Active', '11/15/2023', NULL)";
    client.execute(person, &[]).unwrap();
}

#[allow(dead_code)]
pub fn clear_database(client: &mut Client) {
    // Completely delete the database.
    let queries = "
        DROP TABLE IF EXISTS SERIVCE_RECORD;
        DROP TABLE IF EXISTS DEVICE;
        DROP TABLE IF EXISTS WARRANTY;
        DROP TABLE IF EXISTS PERSON CASCADE;
    ";

    client.batch_execute(queries).unwrap();
}

pub fn query_one(client: &mut Client) {
    // Get the average amount of money that is required to start a new employee
    // in any given department (use nurses as an example)
}

pub fn query_two(client: &mut Client) {
    // Get the average amount of money that is required to keep a given make/model
    // of device in service. This means the average amount of money that is spent
    // on repairs. This kind of data can be used to determine if a device is worth
    // keeping in service, and can allow for depreciation budgeting for that model.
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
    }

    #[test]
    fn project_interaction() {
        let mut client =
            Client::connect("host=localhost user=postgres password=IN$piron54286", NoTls).unwrap();

        // Build the database.
        super::clear_database(&mut client);
        super::build_database(&mut client);

        // Run tests
        // Insert data.
        let person =
            "INSERT INTO PERSON (UserID, FirstName, LastName, Status, DateActive, DateInactive)
            VALUES (1, 'Lucas', 'Vas', 'Active', '11/15/2023', NULL)";

        client.execute(person, &[]).unwrap();

        // Assert tests.
        for row in client
            .query("SELECT FirstName, LastName FROM PERSON", &[])
            .unwrap()
        {
            assert_eq!(row.get::<_, String>(0).trim(), "Lucas");
            assert_eq!(row.get::<_, String>(1).trim(), "Vas");
        }

        // Delete data.
        let delete_person = "DELETE FROM PERSON WHERE UserID = 1";
        client.execute(delete_person, &[]).unwrap();

        // I'll assume that this is considered functional if there's no panic - the devs of the
        // postgres crate should have tested their own crate before release.
        // Also, I don't quite know how to create an error for this crate.
    }
}
