# Step 1: Use the latest official Tomcat image as the base
FROM tomcat:latest

# Step 2: Copy the WAR file into the webapps directory of Tomcat
COPY studentsurvey.war /usr/local/tomcat/webapps/

# Step 3: Expose the port that Tomcat listens to
EXPOSE 8080

# Step 4: Start the Tomcat server
CMD ["catalina.sh", "run"]

