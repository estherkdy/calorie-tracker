USE calorie_tracker;

-- Drop the referencing tables first
DROP TABLE IF EXISTS ClientHobby;
DROP TABLE IF EXISTS ClientGoals;

-- Now drop the Client table
DROP TABLE IF EXISTS Client;

-- Recreate the Client table
CREATE TABLE Client (
    client_id INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    height FLOAT CHECK (height > 0),
    weight FLOAT CHECK (weight > 0)
);

-- Recreate the referencing tables with foreign keys
CREATE TABLE ClientHobby (
    client_id INT,
    hobby VARCHAR(100),
    FOREIGN KEY (client_id) REFERENCES Client(client_id) ON DELETE CASCADE
);

CREATE TABLE ClientGoals (
    goal_id INT AUTO_INCREMENT PRIMARY KEY,
    goal_description VARCHAR(255),
    client_id INT,
    FOREIGN KEY (client_id) REFERENCES Client(client_id) ON DELETE CASCADE
);



--   Trainer table with trainer id as the PK. this stores trainer information
CREATE TABLE Trainer (
    TrainerID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Specialty VARCHAR(100),
    Email VARCHAR(100) UNIQUE  
);



--  Fitnessplan with planID as the PK.
-- clientID(FK) references Client, linking a plan to a client
-- trainerID (FK) refernces Trainer, linking a plan to a trainer
CREATE TABLE FitnessPlan (
    PlanID INT AUTO_INCREMENT PRIMARY KEY,
    ClientID INT,
    TrainerID INT,
    StartDate DATE NOT NULL,
    EndDate DATE,
    Description VARCHAR(255),
    FOREIGN KEY (ClientID) REFERENCES Client(client_id) ON DELETE CASCADE,
    FOREIGN KEY (TrainerID) REFERENCES Trainer(TrainerID) ON DELETE SET NULL,
    CHECK (EndDate IS NULL OR EndDate > StartDate)
);


-- Workout table with workoutID as PK.
-- planID (FK) references FitnessPlan, linking workout to a fitness plan
CREATE TABLE Workout (
    WorkoutID INT AUTO_INCREMENT PRIMARY KEY,
    PlanID INT,
    Name VARCHAR(100) NOT NULL,
    Duration INT CHECK (Duration > 0), -- Duration in minutes
    FOREIGN KEY (PlanID) REFERENCES FitnessPlan(PlanID) ON DELETE CASCADE
);


-- Exercise table with exerciseID as PK. exercise is linked to a specific workout. workoutID references workout
CREATE TABLE Exercise (
    ExerciseID INT AUTO_INCREMENT PRIMARY KEY,
    WorkoutID INT,
    Name VARCHAR(100) NOT NULL,
    Reps INT CHECK (Reps > 0),
    Sets INT CHECK (Sets > 0),
    CaloriesBurned FLOAT CHECK (CaloriesBurned >= 0),
    FOREIGN KEY (WorkoutID) REFERENCES Workout(WorkoutID) ON DELETE CASCADE
);


-- Diet table with dietID as PK. planID(FK) references the fitnessplan for linking
CREATE TABLE Diet (
    DietID INT AUTO_INCREMENT PRIMARY KEY,
    PlanID INT,
    diet_name VARCHAR(255) NOT NULL,
    FOREIGN KEY (PlanID) REFERENCES FitnessPlan(PlanID) ON DELETE CASCADE
);


-- Meal with MealID as PK and dietID as FK , linking each meal to a specific diet
CREATE TABLE Meal (
    MealID INT AUTO_INCREMENT PRIMARY KEY,
    DietID INT,
    meal_name VARCHAR(255) NOT NULL,
    Calories FLOAT CHECK (Calories >= 0),
    Protein FLOAT CHECK (Protein >= 0),
    Carbs FLOAT CHECK (Carbs >= 0),
    Fat FLOAT CHECK (Fat >= 0),
    FOREIGN KEY (DietID) REFERENCES Diet(DietID) ON DELETE CASCADE
);


-- Reminder with reminderID as PK, each reminder associated with a clientID and trainerID (FK)
CREATE TABLE Reminder (
    ReminderID INT AUTO_INCREMENT PRIMARY KEY,
    ClientID INT,
    TrainerID INT,
    Message VARCHAR(255) NOT NULL,
    ReminderDate DATE NOT NULL,
    FOREIGN KEY (ClientID) REFERENCES Client(client_id) ON DELETE CASCADE,
    FOREIGN KEY (TrainerID) REFERENCES Trainer(TrainerID) ON DELETE SET NULL
);
