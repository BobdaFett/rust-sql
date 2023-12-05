// // File created for use with SQLite.

use postgres::Client;

pub fn build_pets(client: &mut Client) {
    println!("Assignment 5a.");
    
    // Cleanup from previous runs.
    let cleanup = "DROP TABLE IF EXISTS PET;
        DROP TABLE IF EXISTS SPECIES;
        DROP TABLE IF EXISTS VET;
        DROP TABLE IF EXISTS VET_SPECIES;";
    client.batch_execute(cleanup).expect("Failed to execute cleanup.");
    
    let create_pet = "CREATE TABLE IF NOT EXISTS PET (PetId int primary key,Name CHAR(32),Species CHAR(5));";
    let insert_pets = "INSERT INTO PET VALUES (1,'Ginger','Dog');
        INSERT INTO PET VALUES (2,'Chappy','Dog');
        INSERT INTO PET VALUES (3,'Fritzy','Dog');
        INSERT INTO PET VALUES (4,'Annie','Cat');
        INSERT INTO PET VALUES (5,'Roo','Cat');";
    let create_species = "CREATE TABLE IF NOT EXISTS SPECIES (Species CHAR(5) PRIMARY KEY, Noise CHAR(4));";
    let insert_species = "INSERT INTO SPECIES VALUES ('Dog','Woof');
        INSERT INTO SPECIES VALUES ('Cat','Meow');
        INSERT INTO SPECIES VALUES ('Horse','Ney');
        INSERT INTO SPECIES VALUES ('Llama','blah');
        INSERT INTO SPECIES VALUES ('Goat','bah')";

    client.execute(create_pet, &[]).expect("Failed to execute command create_pet");
    client.execute(create_species, &[]).expect("Failed to execute create_species");
    client.batch_execute(insert_pets).expect("Failed to execute insert_pets.");
    client.batch_execute(insert_species).expect("Failed to execute insert_species.");

    println!("PET table:");
    for row in client.query("SELECT PetID, Name, Species FROM PET", &[]).expect("Failed to execute query") {
        println!("{}, {}, {}",
            row.get::<usize, i32>(0),
            row.get::<usize, String>(1),
            row.get::<usize, String>(2));
    }

    println!("SPECIES table:");
    for row in client.query("SELECT * FROM SPECIES", &[]).expect("Failed to execute query") {
        println!("{}, {}",
            row.get::<usize, String>(0),
            row.get::<usize, String>(1));
    }

    let create_vets = "CREATE TABLE IF NOT EXISTS VET (Name CHAR(32) PRIMARY KEY, Town CHAR(32));";
    client.execute(create_vets, &[]).expect("Failed to execute create_vets");

    let insert_vets = "INSERT INTO VET VALUES ('Dr. Ellwell', 'Roxbury, CT');
        INSERT INTO VET VALUES ('Dr. Carlson', 'Roxbury, CT');
        INSERT INTO VET VALUES ('Dr. Timm', 'Roxbury, CT');
        INSERT INTO VET VALUES ('Dr. Miller', 'Roxbury, CT');";
    client.batch_execute(insert_vets).expect("Failed to execute insert_vets.");

    // Print out the contents of the VET table.
    println!("VET table:");
    for row in client.query("SELECT * FROM VET", &[]).expect("Failed to execute query") {
        println!("{}, {}",
            row.get::<usize, String>(0),
            row.get::<usize, String>(1));
    }

    client.execute("DROP TABLE IF EXISTS VET_SPECIES", &[]).expect("Failed to execute drop table");

    // We need to create a table to hold the relationship between pets and vets.
    let create_pet_vet = "CREATE TABLE IF NOT EXISTS VET_SPECIES (Species CHAR(5), Name CHAR(32), PRIMARY KEY (Species, Name));";
    client.execute(create_pet_vet, &[]).expect("Failed to execute create_pet_vet");

    // Populate the PET_VET table.
    let insert_pet_vet = "INSERT INTO VET_SPECIES VALUES ('Llama', 'Dr. Ellwell');
        INSERT INTO VET_SPECIES VALUES ('Horse', 'Dr. Ellwell');
        INSERT INTO VET_SPECIES VALUES ('Goat', 'Dr. Ellwell');
        INSERT INTO VET_SPECIES VALUES ('Dog', 'Dr. Carlson');
        INSERT INTO VET_SPECIES VALUES ('Cat', 'Dr. Carlson');
        INSERT INTO VET_SPECIES VALUES ('Horse', 'Dr. Carlson');
        INSERT INTO VET_SPECIES VALUES ('Dog', 'Dr. Timm');
        INSERT INTO VET_SPECIES VALUES ('Cat', 'Dr. Timm');
        INSERT INTO VET_SPECIES VALUES ('Dog', 'Dr. Miller');
        INSERT INTO VET_SPECIES VALUES ('Cat', 'Dr. Miller');";
    client.batch_execute(insert_pet_vet).expect("Failed to execute insert_pet_vet.");

    // Print out the contents of the VET_SPECIES table.
    println!("VET_SPECIES table:");
    for row in client.query("SELECT * FROM VET_SPECIES", &[]).expect("Failed to execute query") {
        println!("{}, {}",
            row.get::<usize, String>(0),
            row.get::<usize, String>(1));
    }

    // Create a query that can be used to find the vets that Ginger can see.
    // Ginger is a dog, so we expect to have a result of Dr. Carlson, Dr. Timm, and Dr. Miller.
    let query = "SELECT V.Name FROM VET_SPECIES AS V,PET AS P,SPECIES AS S WHERE P.Name = 'Ginger' AND P.Species = S.Species AND S.Species = V.Species;";
    println!("Vets that Ginger can see:");
    for row in client.query(query, &[]).expect("Failed to execute query") {
        println!("{}", row.get::<usize, String>(0));
    }

}