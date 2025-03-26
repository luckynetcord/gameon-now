CREATE TABLE CLUBS (
    id SERIAL PRIMARY KEY,  -- Auto-generated ID column
    name VARCHAR(100),
    address VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE MEMBERSHIPS (
    id SERIAL PRIMARY KEY,  -- Auto-generated ID column
    clubId INT,  -- Define clubId as an integer
    name VARCHAR(100),
    price INT,
    description VARCHAR(255),
    benefits TEXT,  -- Add benefits column to store long text
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (clubId) REFERENCES CLUBS(id)  -- Set clubId as a foreign key referencing CLUBS
);