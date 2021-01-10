CREATE TABLE `users` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `first` varchar(255),
  `last` varchar(255),
  `email` varchar(255),
  `created_at` datetime DEFAULT (now())
);

CREATE TABLE `listing` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `tmdb_id` int UNIQUE NOT NULL,
  `type` int,
  `created_at` datetime DEFAULT (now()),
  `modifed` datetime DEFAULT (now())
);

CREATE TABLE `watch_list` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `user_id` int,
  `listing_id` int,
  `created_at` datetime DEFAULT (now()),
  `modifed` datetime DEFAULT (now())
);

CREATE TABLE `ranked` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `user_id` int,
  `listing_id` int,
  `rank` int,
  `created_at` datetime DEFAULT (now()),
  `modifed` datetime DEFAULT (now())
);

CREATE TABLE `tags` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `up_votes` int,
  `down_votes` int,
  `created_at` datetime DEFAULT (now()),
  `modifed` datetime DEFAULT (now())
);

CREATE TABLE `tagged` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `listing_id` int,
  `tag_id` int,
  `created_at` datetime DEFAULT (now())
);

CREATE TABLE `reviews` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `rating` int,
  `review` varchar(255),
  `user_id` int,
  `listing_id` int,
  `created_at` datetime DEFAULT (now()),
  `modifed` datetime DEFAULT (now())
);

CREATE TABLE `user_description` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `up_votes` int,
  `down_votes` int,
  `user_id` int,
  `listing_id` int,
  `created_at` datetime DEFAULT (now()),
  `modifed` datetime DEFAULT (now())
);

ALTER TABLE `watch_list` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

ALTER TABLE `watch_list` ADD FOREIGN KEY (`listing_id`) REFERENCES `listing` (`id`);

ALTER TABLE `ranked` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

ALTER TABLE `ranked` ADD FOREIGN KEY (`listing_id`) REFERENCES `listing` (`id`);

ALTER TABLE `tagged` ADD FOREIGN KEY (`listing_id`) REFERENCES `listing` (`id`);

ALTER TABLE `tagged` ADD FOREIGN KEY (`tag_id`) REFERENCES `tags` (`id`);

ALTER TABLE `reviews` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

ALTER TABLE `reviews` ADD FOREIGN KEY (`listing_id`) REFERENCES `listing` (`id`);

ALTER TABLE `user_description` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

ALTER TABLE `user_description` ADD FOREIGN KEY (`listing_id`) REFERENCES `listing` (`id`);
