# BASE Image
FROM fmk.nexus.onefiserv.net/fmk/java/openjdk17-jre:FMK-06-14-24 AS runtime

# Switch to root user to create group and user
USER root

# Create a non-root user and group
RUN groupadd -r mygroup && useradd -r -g mygroup myuser

# Create a directory for the application and set permissions
RUN mkdir /app && chown -R myuser:mygroup /app

# Set the working directory
WORKDIR /app

# Copy and rename jar with appropriate permissions
COPY --chown=myuser:mygroup target/*.jar app.jar

# Expose the port that the Spring Boot application will run on
EXPOSE 8022

# Switch to the non-root user
USER myuser

# Define the command to run when the container starts
CMD ["java", "-jar", "app.jar"]

