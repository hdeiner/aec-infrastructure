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
|ec2-54-161-12-219.compute-1.amazonaws.com|
|ec2-54-162-138-183.compute-1.amazonaws.com|
|ec2-34-204-44-132.compute-1.amazonaws.com|
|ec2-54-175-210-146.compute-1.amazonaws.com|
|ec2-34-207-146-254.compute-1.amazonaws.com|
|ec2-52-90-173-72.compute-1.amazonaws.com|
|ec2-54-197-137-205.compute-1.amazonaws.com|
|ec2-34-229-0-220.compute-1.amazonaws.com|
|ec2-34-230-35-92.compute-1.amazonaws.com|
|ec2-34-226-209-197.compute-1.amazonaws.com|
|ec2-54-91-152-39.compute-1.amazonaws.com|
|ec2-34-204-47-22.compute-1.amazonaws.com|
|ec2-54-91-171-147.compute-1.amazonaws.com|
|ec2-34-224-78-1.compute-1.amazonaws.com|
|ec2-52-207-242-111.compute-1.amazonaws.com|
|ec2-34-229-9-250.compute-1.amazonaws.com|
|ec2-34-224-23-71.compute-1.amazonaws.com|
|ec2-52-91-58-41.compute-1.amazonaws.com|
|ec2-184-72-211-181.compute-1.amazonaws.com|
|ec2-34-224-38-179.compute-1.amazonaws.com|
|ec2-107-22-150-171.compute-1.amazonaws.com|
|ec2-54-208-159-30.compute-1.amazonaws.com|
|ec2-52-55-175-240.compute-1.amazonaws.com|
|ec2-34-229-176-100.compute-1.amazonaws.com|
|ec2-52-207-224-126.compute-1.amazonaws.com|
|ec2-107-23-169-36.compute-1.amazonaws.com|
|ec2-54-236-207-238.compute-1.amazonaws.com|
|ec2-34-228-56-77.compute-1.amazonaws.com|
|ec2-34-203-13-245.compute-1.amazonaws.com|
|ec2-34-227-60-174.compute-1.amazonaws.com|
|ec2-54-85-15-180.compute-1.amazonaws.com|
|ec2-54-175-118-224.compute-1.amazonaws.com|
|ec2-54-197-165-17.compute-1.amazonaws.com|
|ec2-34-228-165-118.compute-1.amazonaws.com|
|ec2-54-205-211-55.compute-1.amazonaws.com|
|ec2-52-23-203-139.compute-1.amazonaws.com|
|ec2-34-228-42-45.compute-1.amazonaws.com|
|ec2-52-90-100-59.compute-1.amazonaws.com|
|ec2-34-201-112-158.compute-1.amazonaws.com|
|ec2-107-20-28-32.compute-1.amazonaws.com|
|ec2-184-73-27-183.compute-1.amazonaws.com|
|ec2-34-229-142-67.compute-1.amazonaws.com|
|ec2-54-174-220-209.compute-1.amazonaws.com|
|ec2-34-204-48-246.compute-1.amazonaws.com|
|ec2-54-87-197-114.compute-1.amazonaws.com|
|ec2-34-229-10-208.compute-1.amazonaws.com|
|ec2-34-229-91-203.compute-1.amazonaws.com|
|ec2-34-227-221-3.compute-1.amazonaws.com|
|ec2-107-23-30-231.compute-1.amazonaws.com|
|ec2-34-229-149-243.compute-1.amazonaws.com|
|ec2-52-90-125-211.compute-1.amazonaws.com|
|ec2-34-228-146-9.compute-1.amazonaws.com|
|ec2-34-228-68-117.compute-1.amazonaws.com|
|ec2-34-207-144-40.compute-1.amazonaws.com|
|ec2-54-243-26-21.compute-1.amazonaws.com|
|ec2-34-224-101-220.compute-1.amazonaws.com|
|ec2-34-230-21-31.compute-1.amazonaws.com|
|ec2-54-196-3-231.compute-1.amazonaws.com|
|ec2-34-229-129-89.compute-1.amazonaws.com|
|ec2-34-229-218-222.compute-1.amazonaws.com|
|ec2-54-205-234-88.compute-1.amazonaws.com|
|ec2-34-228-73-218.compute-1.amazonaws.com|
|ec2-34-229-172-41.compute-1.amazonaws.com|
|ec2-34-202-205-123.compute-1.amazonaws.com|
|ec2-34-202-165-69.compute-1.amazonaws.com|
|ec2-54-152-2-205.compute-1.amazonaws.com|
|ec2-54-204-230-234.compute-1.amazonaws.com|
|ec2-52-207-66-84.compute-1.amazonaws.com|
|ec2-52-201-255-163.compute-1.amazonaws.com|
|ec2-34-229-13-138.compute-1.amazonaws.com|
|ec2-54-172-196-253.compute-1.amazonaws.com|
|ec2-34-224-173-77.compute-1.amazonaws.com|
|ec2-34-230-85-204.compute-1.amazonaws.com|
|ec2-34-229-165-233.compute-1.amazonaws.com|
|ec2-34-229-178-248.compute-1.amazonaws.com|
