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
|ec2-52-91-35-18.compute-1.amazonaws.com|
|ec2-54-208-59-201.compute-1.amazonaws.com|
|ec2-34-207-67-217.compute-1.amazonaws.com|
|ec2-54-210-142-40.compute-1.amazonaws.com|
|ec2-54-209-209-250.compute-1.amazonaws.com|
|ec2-54-144-237-161.compute-1.amazonaws.com|
|ec2-54-146-223-211.compute-1.amazonaws.com|
|ec2-54-158-245-159.compute-1.amazonaws.com|
|ec2-34-201-76-156.compute-1.amazonaws.com|
|ec2-184-72-68-51.compute-1.amazonaws.com|
|ec2-34-203-216-196.compute-1.amazonaws.com|
|ec2-54-152-44-85.compute-1.amazonaws.com|
|ec2-184-72-183-143.compute-1.amazonaws.com|
|ec2-54-227-3-108.compute-1.amazonaws.com|
|ec2-54-84-232-181.compute-1.amazonaws.com|
|ec2-54-175-245-86.compute-1.amazonaws.com|
|ec2-52-87-180-137.compute-1.amazonaws.com|
|ec2-54-91-215-167.compute-1.amazonaws.com|
|ec2-107-23-252-11.compute-1.amazonaws.com|
|ec2-34-203-204-144.compute-1.amazonaws.com|
|ec2-54-89-251-224.compute-1.amazonaws.com|
|ec2-54-159-16-183.compute-1.amazonaws.com|
|ec2-52-87-157-127.compute-1.amazonaws.com|
|ec2-34-205-73-57.compute-1.amazonaws.com|
|ec2-52-90-51-164.compute-1.amazonaws.com|
|ec2-34-205-156-152.compute-1.amazonaws.com|
|ec2-54-172-101-183.compute-1.amazonaws.com|
|ec2-54-147-140-111.compute-1.amazonaws.com|
|ec2-54-145-117-15.compute-1.amazonaws.com|
|ec2-54-89-142-63.compute-1.amazonaws.com|
|ec2-54-236-170-54.compute-1.amazonaws.com|
|ec2-52-23-228-244.compute-1.amazonaws.com|
|ec2-34-203-226-227.compute-1.amazonaws.com|
|ec2-52-90-75-18.compute-1.amazonaws.com|
|ec2-54-90-73-147.compute-1.amazonaws.com|
|ec2-34-205-154-117.compute-1.amazonaws.com|
|ec2-54-209-104-94.compute-1.amazonaws.com|
|ec2-107-23-69-246.compute-1.amazonaws.com|
|ec2-52-201-232-32.compute-1.amazonaws.com|
|ec2-54-196-59-82.compute-1.amazonaws.com|
|ec2-54-210-26-67.compute-1.amazonaws.com|
|ec2-54-174-205-190.compute-1.amazonaws.com|
|ec2-52-90-45-105.compute-1.amazonaws.com|
|ec2-107-22-134-88.compute-1.amazonaws.com|
|ec2-54-145-134-203.compute-1.amazonaws.com|
|ec2-34-205-140-185.compute-1.amazonaws.com|
|ec2-34-201-51-77.compute-1.amazonaws.com|
|ec2-54-164-88-101.compute-1.amazonaws.com|
|ec2-34-207-89-229.compute-1.amazonaws.com|
|ec2-54-197-43-93.compute-1.amazonaws.com|
