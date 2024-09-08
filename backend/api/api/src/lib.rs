use std::env;
use actix_web::{middleware, App, HttpServer};
use actix_web::web::Data;
use dotenvy::dotenv;
use orm::sea_orm::{Database, DatabaseConnection};

#[derive(Clone)]
struct AppState {
    conn: DatabaseConnection,
}

#[actix_web::main]
async fn start() -> std::io::Result<()> {
    dotenv().expect(".env file is not present");

    let conn = Database::connect(env::var("DATABASE_URL").expect("DATABASE_URL is not set in .env file")).await.unwrap();
    let state = AppState { conn };

    let server = HttpServer::new(move ||
        App::new()
            .app_data(Data::new(state.clone()))
            .wrap(middleware::Logger::default())
    );

    server.bind(("127.0.0.1", 8080))?.run().await?;

    Ok(())
}

pub fn main() {
    let result = start();

    if let Some(err) = result.err() {
        eprintln!("Error: {err}")
    }
}