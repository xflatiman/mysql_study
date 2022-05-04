USE vk;

ALTER TABLE profiles ADD COLUMN is_active BOOL DEFAULT TRUE;

UPDATE profiles SET birthday_at = '2005-01-01' WHERE user_id = 2;

UPDATE profiles SET is_active = FALSE WHERE (birthday_at + INTERVAL 18 YEAR) > CURRENT_DATE;

SELECT * FROM profiles;