insert into user_group_assignment(user_id,group_id)
values
((select id from login where login='Race'), 8);
