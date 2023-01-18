-- Challenge Bonus queries.
-- 1. (2.5 pts)
-- Retrieve all the number of backer_counts in descending order for each `cf_id` for the "live" campaigns. 
SELECT backers_count, cf_id
FROM campaign
WHERE outcome = 'live' 
GROUP BY cf_id
ORDER BY cf_id DESC;


-- 2. (2.5 pts)
-- Using the "backers" table confirm the results in the first query.
select DISTINCT b.cf_id,
	ca.backers_count,
	ca.outcome
FROM backers as b
inner join campaign as ca
on(b.cf_id = ca.cf_id)
WHERE (ca.outcome = 'live')
ORDER BY b.cf_id DESC;



-- 3. (5 pts)
-- Create a table that has the first and last name, and email address of each contact.
-- and the amount left to reach the goal for all "live" projects in descending order. 
select DISTINCT co.first_name,
    co.last_name,
    co.email,
	ca.goal-ca.pledged as remaining_goal_amount
INTO email_contacts
FROM contacts as co
inner join campaign as ca
on(ca.contact_id = co.contact_id)
inner join backers as b
on (b.cf_id = ca.cf_id);

-- Check the table
SELECT DISTINCT ON (remaining_goal_amount) first_name, last_name, email, remaining_goal_amount
FROM email_contacts
order by remaining_goal_amount desc;

-- 4. (5 pts)
-- Create a table, "email_backers_remaining_goal_amount" that contains the email address of each backer in descending order, 
-- and has the first and last name of each backer, the cf_id, company name, description, 
-- end date of the campaign, and the remaining amount of the campaign goal as "Left of Goal". 


select DISTINCT b.first_name,
    b.last_name,
    b.email,
	ca.cf_id,
	ca.company_name,
	ca.description,
	ca.end_date,
	ca.goal-ca.pledged as left_of_goal
INTO backers_email_contacts
FROM contacts as co
inner join campaign as ca
on(ca.contact_id = co.contact_id)
inner join backers as b
on (b.cf_id = ca.cf_id);

-- Check the table
SELECT email, first_name, last_name, cf_id, company_name, description, end_date, left_of_goal 
FROM backers_email_contacts
order by last_name, email;





