
# Welcome to the Ruby on Rails Starter Project!

![TrianglZ Logo](https://techne-staging-uploads.s3.amazonaws.com/trianglz_spon_logo.png)

Hello, future Rails developer! 🎉 We're excited to have you on this journey to mastering Ruby on Rails. This starter project is designed to get you up and running quickly so you can dive right into building your first step authentication module.

## Getting Started

To get started, please follow the instructions below:

### Prerequisites

Ensure you have the following files in your project directory:
1. `.env` file
2. `docker-compose.yml`

If you don't have these files, please request them from your mentor

### Setting Up Your Environment

1. **Start Docker Compose**

    Open your terminal and navigate to your project directory. Run the following command to start the Docker containers:

    ```bash
    docker compose up
    ```

    This command will pull the necessary Docker images (if not already pulled) and start your application containers as defined in the `docker-compose.yml` file.

2. **Access the Web Container**

    Once the containers are up and running, you'll need to access the web container to interact with the Rails application. Run the following command:

    ```bash
    docker exec -it learning_proj-web-1 /bin/bash
    ```

    This command will open a bash shell inside the web container, allowing you to run Rails commands and manage your application.

3. **Open Rails Console**

    Now that you're inside the web container, you can open the Rails console by running:

    ```bash
    rails c
    ```

    The Rails console is a powerful tool that allows you to interact with your application's models and data directly.

### You're All Set!

You're now ready to start exploring and building with Ruby on Rails. If you have any questions or run into any issues, don't hesitate to reach out for help. Happy coding! 🚀

---

Thank you for joining us, and we hope you enjoy the learning experience! 😊
