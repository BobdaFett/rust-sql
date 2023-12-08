mod pets;
mod project;
mod shopfloor;
use postgres::{Client, NoTls};

fn main() {
    let mut client =
        Client::connect("host=localhost user=postgres password=IN$piron54286", NoTls).unwrap();

    project::clear_database(&mut client);
    project::build_database(&mut client);
    project::query_one(&mut client);
}
