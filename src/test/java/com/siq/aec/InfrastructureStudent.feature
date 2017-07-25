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
|ec2-34-207-185-188.compute-1.amazonaws.com|
|ec2-34-224-7-168.compute-1.amazonaws.com|
|ec2-34-230-10-151.compute-1.amazonaws.com|
|ec2-54-172-250-165.compute-1.amazonaws.com|
|ec2-54-209-173-248.compute-1.amazonaws.com|
|ec2-34-229-167-114.compute-1.amazonaws.com|
|ec2-54-144-232-137.compute-1.amazonaws.com|
|ec2-34-229-11-107.compute-1.amazonaws.com|
|ec2-34-229-220-244.compute-1.amazonaws.com|
|ec2-34-202-160-141.compute-1.amazonaws.com|
|ec2-34-228-65-6.compute-1.amazonaws.com|
|ec2-52-201-255-17.compute-1.amazonaws.com|
|ec2-54-89-153-69.compute-1.amazonaws.com|
|ec2-52-90-23-207.compute-1.amazonaws.com|
|ec2-54-87-228-243.compute-1.amazonaws.com|
|ec2-54-162-134-191.compute-1.amazonaws.com|
|ec2-52-91-8-146.compute-1.amazonaws.com|
|ec2-54-162-178-215.compute-1.amazonaws.com|
|ec2-54-227-164-236.compute-1.amazonaws.com|
|ec2-34-229-57-77.compute-1.amazonaws.com|
|ec2-54-145-8-156.compute-1.amazonaws.com|
|ec2-34-226-195-216.compute-1.amazonaws.com|
|ec2-54-91-11-57.compute-1.amazonaws.com|
|ec2-54-174-126-55.compute-1.amazonaws.com|
|ec2-54-144-254-0.compute-1.amazonaws.com|
|ec2-34-202-230-230.compute-1.amazonaws.com|
|ec2-34-203-242-122.compute-1.amazonaws.com|
|ec2-54-80-61-96.compute-1.amazonaws.com|
|ec2-52-54-86-57.compute-1.amazonaws.com|
|ec2-184-72-124-88.compute-1.amazonaws.com|
|ec2-54-159-99-43.compute-1.amazonaws.com|
|ec2-34-228-165-47.compute-1.amazonaws.com|
|ec2-34-230-5-118.compute-1.amazonaws.com|
|ec2-34-229-76-60.compute-1.amazonaws.com|
|ec2-34-229-195-129.compute-1.amazonaws.com|
|ec2-34-227-242-171.compute-1.amazonaws.com|
|ec2-54-85-208-56.compute-1.amazonaws.com|
|ec2-34-229-9-82.compute-1.amazonaws.com|
|ec2-34-229-174-63.compute-1.amazonaws.com|
|ec2-52-91-161-181.compute-1.amazonaws.com|
|ec2-204-236-197-228.compute-1.amazonaws.com|
|ec2-34-230-5-215.compute-1.amazonaws.com|
|ec2-54-243-22-210.compute-1.amazonaws.com|
|ec2-34-229-13-14.compute-1.amazonaws.com|
|ec2-52-90-129-9.compute-1.amazonaws.com|
|ec2-34-230-85-40.compute-1.amazonaws.com|
|ec2-34-229-76-171.compute-1.amazonaws.com|
|ec2-34-202-231-214.compute-1.amazonaws.com|
|ec2-54-210-96-10.compute-1.amazonaws.com|
|ec2-34-229-147-237.compute-1.amazonaws.com|
|ec2-34-207-151-102.compute-1.amazonaws.com|
|ec2-34-229-122-61.compute-1.amazonaws.com|
|ec2-54-144-230-217.compute-1.amazonaws.com|
|ec2-34-224-93-116.compute-1.amazonaws.com|
|ec2-34-229-142-97.compute-1.amazonaws.com|
|ec2-54-89-199-92.compute-1.amazonaws.com|
|ec2-54-87-140-226.compute-1.amazonaws.com|
|ec2-34-229-127-143.compute-1.amazonaws.com|
|ec2-34-224-223-143.compute-1.amazonaws.com|
|ec2-34-228-144-128.compute-1.amazonaws.com|
|ec2-34-224-99-140.compute-1.amazonaws.com|
|ec2-34-229-128-86.compute-1.amazonaws.com|
|ec2-52-87-173-29.compute-1.amazonaws.com|
|ec2-54-174-162-80.compute-1.amazonaws.com|
|ec2-34-226-192-208.compute-1.amazonaws.com|
|ec2-107-23-133-34.compute-1.amazonaws.com|
|ec2-34-229-73-106.compute-1.amazonaws.com|
|ec2-54-152-167-38.compute-1.amazonaws.com|
|ec2-52-204-188-27.compute-1.amazonaws.com|
|ec2-34-207-117-23.compute-1.amazonaws.com|
|ec2-52-200-11-48.compute-1.amazonaws.com|
|ec2-54-164-105-155.compute-1.amazonaws.com|
|ec2-34-228-29-57.compute-1.amazonaws.com|
|ec2-52-90-134-145.compute-1.amazonaws.com|
|ec2-34-207-245-214.compute-1.amazonaws.com|
|ec2-54-209-162-101.compute-1.amazonaws.com|
