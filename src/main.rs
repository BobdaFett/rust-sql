mod pets;
mod project;
mod shopfloor;
use postgres::{Client, NoTls};

fn main() {
    let mut client =
        Client::connect("host=localhost user=postgres password=IN$piron54286", NoTls).unwrap();
    shopfloor::build_shopfloor(&mut client);
    pets::build_pets(&mut client);
    project::build_database(&mut client);
}
