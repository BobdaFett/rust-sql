use chrono::NaiveDate;
use postgres::Client;
use std::fs;

pub fn build_shopfloor(client: &mut Client) {
    // Read the shopfloor.txt file.
    let creation_strings = fs::read_to_string(
        "C:\\Users\\lvas4\\RustroverProjects\\rust-sql\\src\\shopfloor\\shopfloor.txt",
    )
    .expect("Failed to read shopfloor.txt");

    // Cleanup previous runs.
    clear_db(client);

    // Create WORKING_DAY table.
    client
        .execute(
            "CREATE TABLE WORKING_DAY (WorkingDayId INT PRIMARY KEY, Day DATE UNIQUE);",
            &[],
        )
        .expect("Failed to create WORKING_DAY table");
    client.execute("COPY WORKING_DAY FROM 'C:\\Users\\lvas4\\RustroverProjects\\rust-sql\\src\\shopfloor\\calendar.csv' DELIMITER ',' CSV HEADER;", &[])
        .expect("Failed to copy calendar.csv to WORKING_DAY");

    // Run the rest of the commands.
    client
        .batch_execute(creation_strings.as_str())
        .expect("Failed to run shopfloor.txt");
}

#[allow(dead_code)]
pub fn test_q1(client: &mut Client) {
    // Get a list of all the customers, we just want their names and if they're international or not.
    let query = "SELECT Name, International FROM CUSTOMER C";

    for row in client.query(query, &[]).unwrap() {
        println!("{}", row.get::<_, String>(0));
    }
}

#[allow(dead_code)]
pub fn test_q2(client: &mut Client) {
    // Get a list of all machines that haven't shipped yet, using the machine id, customer name, and the date committed.
    let query = "SELECT M.MachineID, C.Name, M.DateCommitted
        FROM MACHINE M, CUSTOMER C
        WHERE M.CustomerID = C.CustomerID AND M.Shipped = 'N'";

    for row in client.query(query, &[]).unwrap() {
        println!(
            "{}, {}, {}",
            row.get::<_, String>(0),
            row.get::<_, String>(1),
            row.get::<_, NaiveDate>(2)
        );
    }
}

#[allow(dead_code)]
pub fn test_q3(client: &mut Client) {
    // We want a list of PCN's and the number of those PCN's that were completed.
    // Should be sorted by PCN and then by section type.
    let query = "SELECT S.PCN, COUNT(S.PCN)
        FROM SECTION S
        WHERE S.Complete = 'Y'
        GROUP BY S.PCN
        ORDER BY S.PCN ASC";

    for row in client.query(query, &[]).unwrap() {
        println!("{}, {}", row.get::<_, String>(0), row.get::<_, i64>(1));
    }
}

#[allow(dead_code)]
pub fn test_q4(client: &mut Client) {
    // We want a list of customer names and if they're international or not.
    // We also want to know the number of machines that they've ordered and the total number that have been shipped.
    let query = "SELECT C.Name, C.International, COUNT(M.MachineID) 
        FROM CUSTOMER C, MACHINE M
        WHERE C.CustomerID = M.CustomerID
        GROUP BY C.Name, C.International
        ORDER BY C.Name ASC";

    println!("Printing first query.");

    for row in client.query(query, &[]).unwrap() {
        println!(
            "{}, {}, {}",
            row.get::<_, String>(0),
            row.get::<_, String>(1),
            row.get::<_, i64>(2)
        );
    }

    // We want to do the second query that the question asked for as well - this was created
    // in order to attempt to combine two commands together.
    let query = "SELECT C.Name, C.International, COUNT(M.Shipped)
        FROM CUSTOMER C, MACHINE M
        WHERE C.CustomerID = M.CustomerID AND
            M.Shipped = 'Y'
        GROUP BY C.Name, C.International
        ORDER BY C.Name ASC";

    println!("Printing second query.");

    for row in client.query(query, &[]).unwrap() {
        println!(
            "{}, {}, {}",
            row.get::<_, String>(0),
            row.get::<_, String>(1),
            row.get::<_, i64>(2)
        );
    }

    // To put these two queries together....
    let query = "SELECT C.Name, C.International, COUNT(M.MachineID), COUNT(M.Shipped) FILTER(WHERE M.Shipped = 'Y')
        FROM CUSTOMER C, MACHINE M
        WHERE C.CustomerID = M.CustomerID
        GROUP BY C.Name, C.International
        ORDER BY C.Name ASC";

    println!("Printing them both together!");

    for row in client.query(query, &[]).unwrap() {
        println!(
            "{}, {}, {}, {}",
            row.get::<_, String>(0),
            row.get::<_, String>(1),
            row.get::<_, i64>(2),
            row.get::<_, i64>(3)
        );
    }

    // Print out the values of the machines with CustomerID 114.
    for row in client
        .query(
            "SELECT CustomerID, Shipped FROM MACHINE WHERE CustomerID = 114",
            &[],
        )
        .unwrap()
    {
        println!("{}, {}", row.get::<_, i32>(0), row.get::<_, String>(1));
    }
}

pub fn clear_db(client: &mut Client) {
    // Clear the database.
    let cleanup = "DROP TABLE IF EXISTS SECTION;
        DROP TABLE IF EXISTS MACHINE;
        DROP TABLE IF EXISTS CUSTOMER;
        DROP TABLE IF EXISTS WORKING_DAY;";
    client
        .batch_execute(cleanup)
        .expect("Failed to cleanup previous runs.");
}

#[allow(dead_code)]
pub fn question1(client: &mut Client) {
    // Run the query for question 1.

    // Use 4/1/2019 - 4/30/2019 as the date range, and create a query that will allow the shipping dept
    // to see how much lumber was shipped the each customer during that time period.
    // We want a list of international machines including the shipping date, and cuber section PCN.
    // List should be ordered by the shipping date.
    let query1 = "SELECT M.MachineID, C.Name, S.PCN, M.DateCommitted
    FROM MACHINE M, CUSTOMER C, SECTION S
    WHERE C.International = 'Y' AND
        M.MachineID = S.MachineID AND
        M.DateCommitted < '2019/4/30' AND
        M.DateCommitted > '2019/4/1' AND
        S.Description = 'Cube Eng' AND
        M.CustomerID = C.CustomerID
    ORDER BY M.DateCommitted ASC;";

    for row in client.query(query1, &[]).unwrap() {
        println!(
            "{}, {}, {}, {}",
            row.get::<_, String>(0),
            row.get::<_, String>(1),
            row.get::<_, String>(2),
            row.get::<_, NaiveDate>(3)
        );
    }
}

#[allow(dead_code)]
pub fn question2(client: &mut Client) {
    // Run the query for question 2.

    // List international machines first.
    // Query should contain PCN for every section within the machines.
    // We aren't given a real date range, so we'll just select all of them.
    let query2 = "SELECT M.MachineID, C.Name, S.PCN, M.DateCommitted, C.International
        FROM MACHINE M, CUSTOMER C, SECTION S
        WHERE M.MachineID = S.MachineID AND
            M.CustomerID = C.CustomerID
        ORDER BY C.International DESC, M.DateCommitted ASC;";

    for row in client.query(query2, &[]).unwrap() {
        println!(
            "{}, {}, {}, {}, {}",
            row.get::<_, String>(0),
            row.get::<_, String>(1),
            row.get::<_, String>(2),
            row.get::<_, NaiveDate>(3),
            row.get::<_, String>(4)
        );
    }
}

#[allow(dead_code)]
pub fn question3(client: &mut Client, machine_id: &str) {
    // Run the query for question 3.

    // We want to be able to update a given machine to appear as shipped.
    // We're given the machine ID.
    let query3 = "UPDATE MACHINE SET Shipped = 'Y' WHERE MachineID = $1";

    let machine = client
        .query_one(
            "SELECT MachineID, Shipped FROM MACHINE WHERE MachineID = $1",
            &[&machine_id],
        )
        .expect("Failed to get machine the first time.");
    println!(
        "Before update: {}, {}",
        machine.get::<_, String>(0),
        machine.get::<_, String>(1)
    );

    client
        .execute(query3, &[&machine_id])
        .expect("Failed to edit machine.");

    let machine = client
        .query_one(
            "SELECT MachineID, Shipped FROM MACHINE WHERE MachineID = $1",
            &[&machine_id],
        )
        .expect("Failed to get machine the second time.");
    println!(
        "After update: {}, {}",
        machine.get::<_, String>(0),
        machine.get::<_, String>(1)
    );
}

#[allow(dead_code)]
pub fn question4(client: &mut Client) {
    // Run the query for question 4.

    // We need the integration start date, customer name, section description, PCN, and section scheduled start date.
    // We're looking for sections that are now considered late after a given date, meaning that we're looking for sections
    // that are not complete but their scheduled start date is before the given date.
    // A "query that lists sections that are not complete for machines that are to be integrated before a given date."
    let query4 = "SELECT W.Day, M.MachineID, C.Name, S.Description, S.PCN
        FROM MACHINE M, CUSTOMER C, SECTION S, WORKING_DAY W
        WHERE M.MachineID = S.MachineID AND
            M.CustomerID = C.CustomerID AND
            M.DateCommitted >= '2019/4/1' AND
            M.DateCommitted < '2019/5/1' AND
            W.WorkingDayId = M.IntegrationStart AND
            W.Day < '2019/4/1' AND
            S.Complete = 'N'
        ORDER BY W.WorkingDayId ASC";

    for row in client.query(query4, &[]).unwrap() {
        println!(
            "{}, {}, {}, {}, {}",
            row.get::<_, NaiveDate>(0),
            row.get::<_, String>(1),
            row.get::<_, String>(2),
            row.get::<_, String>(3),
            row.get::<_, String>(4)
        );
    }
}

#[allow(dead_code)]
pub fn question5(client: &mut Client) {
    // Run the query for question 5.

    // We want a list of machines that are scheduled to be integrated (but not completed) sorted by date.
    // The M.IntegrationStart + M.IntegrationDays is the day that the machine is scheduled to be integrated.
    // Since the WorkingDayId's are sequential, we can just add the IntegrationDays to the IntegrationStart.
    let query5 = "SELECT M.MachineID, W.Day
        FROM MACHINE M, WORKING_DAY W
        WHERE M.IntegrationStart + M.IntegrationDays = W.WorkingDayId AND
            M.Shipped = 'N'
        ORDER BY W.Day ASC";

    for row in client.query(query5, &[]).unwrap() {
        println!(
            "{}, {}",
            row.get::<_, String>(0),
            row.get::<_, NaiveDate>(1)
        );
    }
}

#[allow(dead_code)]
pub fn question6(client: &mut Client) {
    // What machines have commitment dates where the customer has not committed more than 30 days before
    // the actual commitment. Logically I would be more worried about when the date is *less* than 30 days.

    let query6 = "SELECT M.MachineID, M.DateCommitted, M.DateCommitmentMade
        FROM MACHINE M, WORKING_DAY W
        WHERE M.CustomerCommited = 'N' AND
            M.DateCommitted - CURRENT_DATE < 30";

    for row in client.query(query6, &[]).unwrap() {
        println!(
            "{}, {}, {}",
            row.get::<_, String>(0),
            row.get::<_, NaiveDate>(1),
            row.get::<_, NaiveDate>(2)
        );
    }
}

#[allow(dead_code)]
pub fn question7(client: &mut Client, machine_id: &str) {
    // Create a set of queries that will allow someone to mark a machine as cancelled.
    // These should be assigned to customer STOCK with CustomerID = 1.
    // Machines and their parts should be able to be reassigned to another customer as well.

    let set_stock = "UPDATE MACHINE SET CustomerID = 1 WHERE MachineID = 'N2019501'";
    let use_complete_parts =
        "UPDATE SECTION SET MachineID = 'N2019501' WHERE MachineID = 'N2019501' AND Complete = 'Y'";

    client.execute(set_stock, &[&machine_id]).unwrap();
    client.execute(use_complete_parts, &[&machine_id]).unwrap();
}

#[allow(dead_code)]
pub fn select_machine(client: &mut Client) {
    let query = "SELECT * FROM MACHINE";

    for row in client.query(query, &[]).unwrap() {
        println!("{}", row.get::<_, String>(0));
    }
}

#[cfg(test)]
mod testing {
    use postgres::{Client, NoTls};

    #[test]
    fn build_shopfloor() {
        // Run function.
        let mut client =
            Client::connect("host=localhost user=postgres password=IN$piron54286", NoTls).unwrap();

        super::build_shopfloor(&mut client);
    }

    #[test]
    fn test_q1() {
        let mut client =
            Client::connect("host=localhost user=postgres password=IN$piron54286", NoTls).unwrap();

        super::build_shopfloor(&mut client);
        super::test_q4(&mut client);
    }

    #[test]
    fn test_q2() {
        let mut client =
            Client::connect("host=localhost user=postgres password=IN$piron54286", NoTls).unwrap();

        super::build_shopfloor(&mut client);
        super::test_q4(&mut client);
    }

    #[test]
    fn test_q3() {
        let mut client =
            Client::connect("host=localhost user=postgres password=IN$piron54286", NoTls).unwrap();

        super::build_shopfloor(&mut client);
        super::test_q4(&mut client);
    }

    #[test]
    fn test_q4() {
        let mut client =
            Client::connect("host=localhost user=postgres password=IN$piron54286", NoTls).unwrap();

        super::clear_db(&mut client);
        super::build_shopfloor(&mut client);
        super::test_q4(&mut client);
    }
}
