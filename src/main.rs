use axum::Router;
use tower_http::services::ServeDir;
use tracing::{info, Level};
use tracing_subscriber::FmtSubscriber;
use walkdir::WalkDir;

#[shuttle_runtime::main]
async fn main() -> shuttle_axum::ShuttleAxum {
    for entry in WalkDir::new("assets").into_iter().filter_map(Result::ok) {
        let path = entry.path();
        if path.is_file() {
            info!("Found file: {}", path.display());
        } else if path.is_dir() {
            info!("Found dir: {}", path.display());
        }
    }

    // ServeDir falls back to serve index.html when requesting a directory
    let router = Router::new().fallback_service(ServeDir::new("assets"));

    Ok(router.into())
}
