# ==================================================================================
# C. OAuth
# ==================================================================================

# Use the official Keycloak image
FROM quay.io/keycloak/keycloak:22.0

# Set the working directory
WORKDIR /opt/keycloak

# Copy the custom provider JAR file if needed
COPY keycloak-apikeys-1.0.1.jar /opt/keycloak/providers/

# Copy the realm-export.json file into the container
COPY realm-export.json /opt/keycloak/data/import/realm-export.json 