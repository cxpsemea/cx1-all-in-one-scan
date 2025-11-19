#[macro_use] extern crate rocket;

use rocket::tokio::process::Command;

#[get("/ping_domain?<domain>")]
async fn ping_domain(domain: String) -> String {
    let mut output: Vec<u8>;
    let command = "ping";
    let cmd_val = [command, &domain].join(" ");   // ❌ vulnerable: user input injected

    output = Command::new(cmd_val)
        .output()
        .expect("failed to execute process")
        .stdout;

    std::str::from_utf8(&output).unwrap().to_string()
}

#[launch]
fn rocket() -> _ {
    rocket::build().mount("/", routes![ping_domain])
}
