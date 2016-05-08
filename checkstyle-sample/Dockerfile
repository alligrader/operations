FROM java:7
COPY . /usr/src/myapp
WORKDIR /usr/src/myapp
CMD ["java", "-jar", "checkstyle-6.17-all.jar", "-c", "google.xml", "-f", "xml", "Main.java"]
