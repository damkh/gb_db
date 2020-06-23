DESC profiles;
ALTER TABLE profiles
	ADD CONSTRAINT profiles_user_id_fk
		FOREIGN KEY profiles(user_id) REFERENCES users(id)
			ON DELETE CASCADE,
	ADD CONSTRAINT profiles_photo_id_fk
		FOREIGN KEY profiles(photo_id) REFERENCES media(id)
			ON DELETE SET NULL;
			
		
DESC messages ;
ALTER TABLE messages 
	ADD CONSTRAINT messages_from_user_id_fk
		FOREIGN KEY messages(from_user_id) REFERENCES users(id),
	ADD CONSTRAINT messages_to_user_id_fk
		FOREIGN KEY messages(to_user_id) REFERENCES users(id),
	ADD CONSTRAINT messages_media_id_fk
		FOREIGN KEY messages(media_id) REFERENCES media(id);
	

DESC user_statuses;
DESC users;
ALTER TABLE users 
	ADD CONSTRAINT users_user_status_fk
		FOREIGN KEY users(user_status) REFERENCES user_statuses(id);

-- SELECT * FROM information_schema.TABLE_CONSTRAINTS WHERE TABLE_NAME = 'communities_users';
	
-- ALTER TABLE communities_users
-- 	DROP FOREIGN KEY communities_users_ibfk_2;


DESC communities_users ;
ALTER TABLE communities_users 
	ADD CONSTRAINT community_users_community_id_fk
		FOREIGN KEY community_users(community_id) REFERENCES communities(id)
			ON DELETE CASCADE,
	ADD CONSTRAINT community_users_user_id_fk
		FOREIGN KEY community_users(user_id) REFERENCES users(id)
			ON DELETE CASCADE;
	
DESC media;
ALTER TABLE media 
	ADD CONSTRAINT media_media_type_id_fk
		FOREIGN KEY media(media_type_id) REFERENCES media_types(id),
	ADD CONSTRAINT media_user_id_fk
		FOREIGN KEY media(user_id) REFERENCES users(id)
			ON DELETE CASCADE;

DESC friendship ;
ALTER TABLE friendship 
	ADD CONSTRAINT friendship_user_id_fk
		FOREIGN KEY friendship(user_id) REFERENCES users(id)
			ON DELETE CASCADE,
	ADD CONSTRAINT friendship_friend_id_fk
		FOREIGN KEY friendship(friend_id) REFERENCES users(id)
			ON DELETE CASCADE,
	ADD CONSTRAINT friendship_status_id_fk
		FOREIGN KEY friendship(status_id) REFERENCES friendship_statuses(id);
	
SELECT * FROM target_types tt ;

DESC likes;
ALTER TABLE likes 
	ADD CONSTRAINT likes_user_id_fk
		FOREIGN KEY likes(user_id) REFERENCES users(id)
			ON DELETE CASCADE,
	ADD CONSTRAINT likes_target_type_id_fk
		FOREIGN KEY likes(target_type_id) REFERENCES target_types(id);	
	



