Feature: Agile Engineering Course Infrastructure as Code for Student Machines

  Scenario Outline: Check Student connectivity

    When I look at "<aecStudentInstance>"
    Then it should be running "sshd" on port "22"
    And it should be running "guacd" on port "4822"
    And it should be running "Xtightvnc" on port "5901"
    And it should be running "java" on port "8080"
    And port "22" should be open
    And port "80" should be open

    Examples:
      |aecStudentInstance                        |
|ec2-54-87-39-202.compute-1.amazonaws.com|
|ec2-52-202-140-212.compute-1.amazonaws.com|
|ec2-34-207-55-12.compute-1.amazonaws.com|
|ec2-184-72-142-46.compute-1.amazonaws.com|
|ec2-184-73-30-164.compute-1.amazonaws.com|
|ec2-107-23-215-25.compute-1.amazonaws.com|
|ec2-54-147-106-224.compute-1.amazonaws.com|
|ec2-54-145-236-234.compute-1.amazonaws.com|
|ec2-54-197-163-44.compute-1.amazonaws.com|
|ec2-34-203-193-96.compute-1.amazonaws.com|
|ec2-54-145-245-190.compute-1.amazonaws.com|
|ec2-54-86-45-14.compute-1.amazonaws.com|
|ec2-54-89-96-43.compute-1.amazonaws.com|
|ec2-54-145-195-212.compute-1.amazonaws.com|
|ec2-54-226-221-35.compute-1.amazonaws.com|
|ec2-34-207-138-31.compute-1.amazonaws.com|
|ec2-54-83-177-111.compute-1.amazonaws.com|
|ec2-54-89-243-147.compute-1.amazonaws.com|
|ec2-107-20-49-142.compute-1.amazonaws.com|
|ec2-54-236-254-119.compute-1.amazonaws.com|
|ec2-54-82-158-177.compute-1.amazonaws.com|
|ec2-107-21-198-44.compute-1.amazonaws.com|
|ec2-54-165-65-192.compute-1.amazonaws.com|
|ec2-52-90-122-13.compute-1.amazonaws.com|
|ec2-54-152-114-151.compute-1.amazonaws.com|
