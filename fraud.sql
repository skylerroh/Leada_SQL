USE Project;
SHOW TABLES;

SELECT count(*) FROM Activity;
SELECT count(*) FROM User;
SELECT count(*) FROM UserActivity;

DESCRIBE Activity;
DESCRIBE User;
DESCRIBE UserActivity;

SELECT * FROM Activity LIMIT 50;
SELECT * FROM User LIMIT 50;
SELECT * FROM UserActivity LIMIT 50;

SELECT distinct(activity_type) FROM Activity;

SELECT activity_type, count(*) #types of activity and how much of each
FROM Activity
GROUP BY activity_type;


SELECT U.user_id, U.email, A.count #want to see user_id, email, and corresponding activity count
FROM User AS U
JOIN (SELECT user_id, count(*) AS count #joining subquery table that contains user_id and corresponding activity count
	  FROM UserActivity 
      GROUP BY user_id) as A
ON U.user_id = A.user_id #joining on user_id
ORDER BY A.count DESC; #ordering from high to low activity

SELECT U.state, SUM(A.count) #want to see states and the sum of all activity from Users from that state
FROM User AS U
JOIN (SELECT user_id, count(*) AS count #joining subquery table that contains user_id and corresponding activity count
	  FROM UserActivity 
      GROUP BY user_id) as A
ON U.user_id = A.user_id #joining on user_id
GROUP BY U.state #aggregate by state
ORDER BY SUM(A.count) DESC; #ordering from high to low activity

SELECT HOUR(activity_time) as hr, count(*) #extracting hour part of date and count of records
FROM UserActivity
GROUP BY hr #grouping by hour
ORDER BY count(*) DESC; #high to low count

SELECT MINUTE(activity_time) as hr, count(*) #same as above for minutes
FROM UserActivity
GROUP BY hr
ORDER BY count(*) DESC;

SELECT HOUR(activity_time) as hr, count(*)
FROM UserActivity as UA
WHERE UA.user_id = (SELECT user_id FROM User WHERE email = 'saunsi_la12@virgilio.it')#get user_id for email 'saunsi_la12@virgilio.it'
GROUP BY hr
ORDER BY count(*) DESC;

SELECT HOUR(activity_time) as hr, count(*)
FROM UserActivity as UA
WHERE UA.user_id = (SELECT user_id FROM User WHERE email = 'dr_abdul.musa01@msn.com') #get user_id for email 'dr_abdul.musa01@msn.com'
GROUP BY hr
ORDER BY count(*) DESC;


SELECT count(*) #how many users are there in the User table
FROM User;

SELECT count(*) #how many records in the following subquery = number of such users
FROM (SELECT user_id, count(*) #which user_ids satisfy this above requirement
	  FROM UserActivity 
	  GROUP BY user_id
	  HAVING count(*) > 50) as A; #limit to users above 50 total activity



SELECT user_id, MAX(dist.count), MIN(dist.count), (MAX(dist.count) - MIN(dist.count)) / MAX(dist.count) * 100 as percent_dif #use max and min functions to see heavy users and calculate percent change from highest to lowest activity hour
FROM (SELECT user_id, HOUR(activity_time) as hr, COUNT(activity_id) as count #table containing all combinations of user_id and hours
	  FROM UserActivity
	  GROUP BY user_id, HOUR(activity_time)) as dist
GROUP BY dist.user_id
ORDER BY percent_dif ASC;

#adding above 50 activity, at least 16 hours, and % dif < 50 clauses
SELECT user_id, MAX(dist.count), MIN(dist.count), (MAX(dist.count) - MIN(dist.count)) / MAX(dist.count) * 100 as percent_dif  #use max and min functions to see heavy users and calculate percent change from highest to lowest activity hour
FROM (SELECT user_id, HOUR(activity_time) as hr, COUNT(activity_id) as count #table containing combinations of user_id and hours and corresponding amount of activity
	  FROM UserActivity
	  GROUP BY user_id, HOUR(activity_time)) as dist
GROUP BY dist.user_id
HAVING COUNT(*) >= 16 AND SUM(dist.count) > 50 AND percent_dif < 50
ORDER BY percent_dif ASC;


#adding above 1000 activity, at least 16 hours, and % dif < 50 clauses
SELECT user_id, MAX(dist.count), MIN(dist.count), (MAX(dist.count) - MIN(dist.count)) / MAX(dist.count) * 100 as percent_dif #use max and min functions to see heavy users and calculate percent change from highest to lowest activity hour
FROM (SELECT user_id, HOUR(activity_time) as hr, COUNT(activity_id) as count #table containing combinations of user_id and hours and corresponding amount of activity
	  FROM UserActivity
	  GROUP BY user_id, HOUR(activity_time)) as dist
GROUP BY dist.user_id 
HAVING COUNT(*) >= 16 AND SUM(dist.count) > 1000
ORDER BY percent_dif ASC;



#100644 example user's distribution
SELECT HOUR(activity_time) as hr, count(*)
FROM UserActivity
WHERE user_id = 100644 #100644 example user #join on single user_id
GROUP BY hr
ORDER BY count(*) DESC;