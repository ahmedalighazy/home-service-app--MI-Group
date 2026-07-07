# Addresses API Endpoints

### GET /api/addresses/{id}
**Summary:** Get address by ID
**Description:** Get address details by ID
**Success Response:**
Status 200:
  - id (optional): string (uuid) - Address ID
  - longitude (optional): number (double) - Longitude
  - latitude (optional): number (double) - Latitude
  - type (optional): enum: HOME, OFFICE
  - description (optional): string - Address description
  - label (optional): string - Address label
  - streetName (optional): string - Street name
  - notes (optional): string - Additional notes
  - buildingNumber (optional): string - Building number
  - apartmentNumber (optional): string - Apartment number
  - floorNumber (optional): string - Floor number
  - isDefault (optional): boolean - Default address
  - userId (optional): string (uuid) - Owner user ID
  - userName (optional): string - Owner name
  - createdAt (optional): string (date-time) - Creation timestamp
  - updatedAt (optional): string (date-time) - Last update timestamp
**Error Responses:**
Status Codes: 403, 404
---
### PUT /api/addresses/{id}
**Summary:** Update address
**Description:** Update an address owned by the current authenticated user
**Request Body:**
  - longitude (optional): number (double) - Longitude
  - latitude (optional): number (double) - Latitude
  - type (optional): enum: HOME, OFFICE
  - description (optional): string - Address description
  - label (optional): string - Address label
  - streetName (optional): string - Street name
  - notes (optional): string - Additional notes
  - buildingNumber (optional): string - Building number
  - apartmentNumber (optional): string - Apartment number
  - floorNumber (optional): string - Floor number
  - isDefault (optional): boolean - Default address
**Success Response:**
Status 200:
  - id (optional): string (uuid) - Address ID
  - longitude (optional): number (double) - Longitude
  - latitude (optional): number (double) - Latitude
  - type (optional): enum: HOME, OFFICE
  - description (optional): string - Address description
  - label (optional): string - Address label
  - streetName (optional): string - Street name
  - notes (optional): string - Additional notes
  - buildingNumber (optional): string - Building number
  - apartmentNumber (optional): string - Apartment number
  - floorNumber (optional): string - Floor number
  - isDefault (optional): boolean - Default address
  - userId (optional): string (uuid) - Owner user ID
  - userName (optional): string - Owner name
  - createdAt (optional): string (date-time) - Creation timestamp
  - updatedAt (optional): string (date-time) - Last update timestamp
**Error Responses:**
Status Codes: 400, 403, 404
---
### DELETE /api/addresses/{id}
**Summary:** Delete address
**Description:** Delete an address owned by the current authenticated user
**Success Response:**
Status 204:
Description: Address deleted successfully
**Error Responses:**
Status Codes: 403, 404
---
### POST /api/addresses
**Summary:** Create address
**Description:** Create a new address for the current authenticated user
**Request Body:**
  - longitude (required): number (double) - Longitude
  - latitude (required): number (double) - Latitude
  - type (required): enum: HOME, OFFICE
  - description (optional): string - Address description
  - label (optional): string - Address label
  - streetName (optional): string - Street name
  - notes (optional): string - Additional notes
  - buildingNumber (optional): string - Building number
  - apartmentNumber (optional): string - Apartment number
  - floorNumber (optional): string - Floor number
  - isDefault (optional): boolean - Default address
**Success Response:**
Status 201:
  - id (optional): string (uuid) - Address ID
  - longitude (optional): number (double) - Longitude
  - latitude (optional): number (double) - Latitude
  - type (optional): enum: HOME, OFFICE
  - description (optional): string - Address description
  - label (optional): string - Address label
  - streetName (optional): string - Street name
  - notes (optional): string - Additional notes
  - buildingNumber (optional): string - Building number
  - apartmentNumber (optional): string - Apartment number
  - floorNumber (optional): string - Floor number
  - isDefault (optional): boolean - Default address
  - userId (optional): string (uuid) - Owner user ID
  - userName (optional): string - Owner name
  - createdAt (optional): string (date-time) - Creation timestamp
  - updatedAt (optional): string (date-time) - Last update timestamp
**Error Responses:**
Status Codes: 400, 401
---
### GET /api/addresses/user/{userId}
**Summary:** Get addresses by user ID
**Description:** Get paginated addresses by user ID
**Success Response:**
Status 200:
  - totalElements (optional): integer (int64)
  - totalPages (optional): integer (int32)
  - pageable (optional):     - paged (optional): boolean
    - pageNumber (optional): integer (int32)
    - pageSize (optional): integer (int32)
    - unpaged (optional): boolean
    - offset (optional): integer (int64)
    - sort (optional):       - sorted (optional): boolean
      - unsorted (optional): boolean
      - empty (optional): boolean
  - first (optional): boolean
  - last (optional): boolean
  - size (optional): integer (int32)
  - content (optional): Array of:
      - id (optional): string (uuid) - Address ID
      - longitude (optional): number (double) - Longitude
      - latitude (optional): number (double) - Latitude
      - type (optional): enum: HOME, OFFICE
      - description (optional): string - Address description
      - label (optional): string - Address label
      - streetName (optional): string - Street name
      - notes (optional): string - Additional notes
      - buildingNumber (optional): string - Building number
      - apartmentNumber (optional): string - Apartment number
      - floorNumber (optional): string - Floor number
      - isDefault (optional): boolean - Default address
      - userId (optional): string (uuid) - Owner user ID
      - userName (optional): string - Owner name
      - createdAt (optional): string (date-time) - Creation timestamp
      - updatedAt (optional): string (date-time) - Last update timestamp
  - number (optional): integer (int32)
  - sort (optional):     - sorted (optional): boolean
    - unsorted (optional): boolean
    - empty (optional): boolean
  - numberOfElements (optional): integer (int32)
  - empty (optional): boolean
**Error Responses:**
Status Codes: 403, 404
---
### GET /api/addresses/me
**Summary:** Get my addresses
**Description:** Get paginated addresses for the current authenticated user
**Success Response:**
Status 200:
  - totalElements (optional): integer (int64)
  - totalPages (optional): integer (int32)
  - pageable (optional):     - paged (optional): boolean
    - pageNumber (optional): integer (int32)
    - pageSize (optional): integer (int32)
    - unpaged (optional): boolean
    - offset (optional): integer (int64)
    - sort (optional):       - sorted (optional): boolean
      - unsorted (optional): boolean
      - empty (optional): boolean
  - first (optional): boolean
  - last (optional): boolean
  - size (optional): integer (int32)
  - content (optional): Array of:
      - id (optional): string (uuid) - Address ID
      - longitude (optional): number (double) - Longitude
      - latitude (optional): number (double) - Latitude
      - type (optional): enum: HOME, OFFICE
      - description (optional): string - Address description
      - label (optional): string - Address label
      - streetName (optional): string - Street name
      - notes (optional): string - Additional notes
      - buildingNumber (optional): string - Building number
      - apartmentNumber (optional): string - Apartment number
      - floorNumber (optional): string - Floor number
      - isDefault (optional): boolean - Default address
      - userId (optional): string (uuid) - Owner user ID
      - userName (optional): string - Owner name
      - createdAt (optional): string (date-time) - Creation timestamp
      - updatedAt (optional): string (date-time) - Last update timestamp
  - number (optional): integer (int32)
  - sort (optional):     - sorted (optional): boolean
    - unsorted (optional): boolean
    - empty (optional): boolean
  - numberOfElements (optional): integer (int32)
  - empty (optional): boolean
**Error Responses:**
Status Codes: 401
---
