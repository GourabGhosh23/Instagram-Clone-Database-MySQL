### Find out the top 5 longest followers from the data

select * from users
order by created_at
limit 5;

### what day of the week do most users register on? to schedule an ad campaign

select dayname(created_at) as week_day, count(*) as number_of_users
from users
group by week_day
order by number_of_users desc;

### We want to target our inactive users with an email campaign. Find the users who have never posted a photo

select users.id, users.username, photos.image_url 
from users
left join photos on users.id=photos.user_id
where photos.image_url is null;

### we are running a new contest to see who can get the most likes on a single photo. who won?

select users.id as user_id, users.username, photos.id as photo_id, photos.image_url, count(likes.user_id) as number_of_likes
from users
join photos on users.id=photos.user_id
join likes on photos.id=likes.photo_id
group by user_id, users.username, photos.image_url, photo_id
order by number_of_likes desc
limit 1;

### what are the most used hashtags?

select tags.id, tags.tag_name, count(photo_tags.tag_id) as used_times
from tags
join photo_tags
on tags.id=photo_tags.tag_id
group by tags.id, tags.tag_name
order by used_times desc;

### we have small problem with bots on our site
### Find users who have liked every single photo on the site

select username, 
       count(*) as num_likes 
from   users 
       join likes 
               on users.id = likes.user_id 
group  by likes.user_id 
having num_likes = (select count(*) 
                    from   photos);
