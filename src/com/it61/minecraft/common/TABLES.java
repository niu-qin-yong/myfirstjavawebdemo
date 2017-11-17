package com.it61.minecraft.common;

public class TABLES {
	public static final String users = "CREATE TABLE `users` ("
	  + "`id` int(11) NOT NULL AUTO_INCREMENT,"
	  + "`username` varchar(16) NOT NULL,"
	  + "`password` varchar(16) NOT NULL,"
	  + "`nick_name` varchar(32),"
	  + "`gender` char(6) DEFAULT NULL,"
	  + "`age` int(1) DEFAULT '10',"
	  + "`birth` varchar(16) DEFAULT '2007-01-01',"
	  + "`class` int(11) DEFAULT '1',"
	  + "`phonenumber` varchar(16) DEFAULT NULL,"
	  + "`photo` blob,"
	  + "`star` varchar(16) DEFAULT NULL,"
	  + "`email` varchar(24) DEFAULT NULL,"
	  + "`grade` int(11) DEFAULT '1',"
	  + "`level` int(11) DEFAULT '30',"
	  + "PRIMARY KEY (`id`),"
	  + "UNIQUE KEY `username` (`username`)"
	+ ") ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;";
	
	public static final String albums = 
			" CREATE TABLE `albums` ( "
			+ "  `id` int(11) NOT NULL AUTO_INCREMENT, "
			+ "    `name` varchar(32) NOT NULL, "
			+ "    `des` varchar(128) DEFAULT NULL, "
			+ "    `user_id` int(11) NOT NULL, "
			+ "    `create_time` datetime DEFAULT CURRENT_TIMESTAMP, "
			+ "    PRIMARY KEY (`id`), "
			+ "    KEY `user_id` (`user_id`), "
			+ "    CONSTRAINT `albums_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) "
			+ "  ) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8; ";
	
	public static final String comments = 
	"CREATE TABLE `comments` ("
			+ "   `id` int(11) NOT NULL AUTO_INCREMENT,"
			+ "  `content` text NOT NULL,"
			+ "    `commenter_id` int(11) NOT NULL,"
			+ "    `commenter_name` varchar(24) NOT NULL,"
			+ "    `moment_id` int(11) NOT NULL,"
			+ "    `daytime` datetime DEFAULT CURRENT_TIMESTAMP,"
			+ "    PRIMARY KEY (`id`),"
			+ "    KEY `moment_id` (`moment_id`),"
			+ "    KEY `commenter_id` (`commenter_id`),"
			+ "    CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`moment_id`) REFERENCES `moments` (`id`),"
			+ "    CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`commenter_id`) REFERENCES `users` (`id`)"
			+ "  ) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;";
	
	public static final String favors = 
	"CREATE TABLE `favors` ("
			+ "`id` int(11) NOT NULL AUTO_INCREMENT,"
			+ "`moment_id` int(11) NOT NULL,"
			  + "`favor_id` int(11) NOT NULL,"
			  + "`favor_name` varchar(24) DEFAULT NULL,"
			  + "`daytime` datetime DEFAULT CURRENT_TIMESTAMP,"
			  + "PRIMARY KEY (`id`),"
			  + "KEY `moment_id` (`moment_id`),"
			  + "KEY `favor_id` (`favor_id`),"
			  + "CONSTRAINT `favors_ibfk_1` FOREIGN KEY (`moment_id`) REFERENCES `moments` (`id`),"
			  + "CONSTRAINT `favors_ibfk_2` FOREIGN KEY (`favor_id`) REFERENCES `users` (`id`)"
			+ ") ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;";
	
	public static final String friends = 
	"CREATE TABLE `friends` ("
			+ "`id` int(11) NOT NULL AUTO_INCREMENT,"
			+ "`ower_id` int(11) NOT NULL,"
			  + "`fri_id` int(11) NOT NULL,"
			  + "`fri_name` varchar(32) NOT NULL,"
			  + "PRIMARY KEY (`id`),"
			  + "KEY `ower_id` (`ower_id`),"
			  + "KEY `fri_id` (`fri_id`),"
			  + "CONSTRAINT `friends_ibfk_1` FOREIGN KEY (`ower_id`) REFERENCES `users` (`id`),"
			  + "CONSTRAINT `friends_ibfk_2` FOREIGN KEY (`fri_id`) REFERENCES `users` (`id`)"
			+ ") ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;";
	
	public static final String moments = 
	"CREATE TABLE `moments` ("
			+ "`id` int(11) NOT NULL AUTO_INCREMENT,"
			+ "`content` text NOT NULL,"
			  + "`daytime` datetime DEFAULT CURRENT_TIMESTAMP,"
			  + "`pic` blob,"
			  + "`sender_id` int(11) NOT NULL,"
			  + "`sender_name` varchar(24) DEFAULT NULL,"
			  + "`sender_level` int(11) DEFAULT '30',"
			  + "PRIMARY KEY (`id`),"
			  + "KEY `sender_id` (`sender_id`),"
			  + "CONSTRAINT `moments_ibfk_1` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`)"
			+ ") ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8;";
	
	public static final String musics = 
	"CREATE TABLE `musics` ("
			+ " `id` int(11) NOT NULL AUTO_INCREMENT,"
			+ "`music` varchar(64) NOT NULL,"
			  + "`poster` varchar(64) NOT NULL,"
			  + "`title` varchar(32) DEFAULT NULL,"
			  + "`singer` varchar(32) DEFAULT NULL,"
			  + "`like_count` int(11) DEFAULT '0',"
			  + "`server_side` tinyint(1) DEFAULT NULL,"
			  + "`user_id` int(32) DEFAULT NULL,"
			  + "`upload_time` datetime DEFAULT CURRENT_TIMESTAMP,"
			  + "PRIMARY KEY (`id`),"
			  + "KEY `user_id_idx` (`user_id`),"
			  + "CONSTRAINT `user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION"
			+ ") ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;";
	
	public static final String pictures = 
	"CREATE TABLE `pictures` ("
			+ " `id` int(11) NOT NULL AUTO_INCREMENT,"
			+ "`user_id` int(11) NOT NULL,"
			  + "`album_id` int(11) NOT NULL,"
			  + "`pic_name` varchar(128) NOT NULL,"
			  + "`create_time` datetime DEFAULT CURRENT_TIMESTAMP,"
			  + "PRIMARY KEY (`id`),"
			  + "UNIQUE KEY `pic_name` (`pic_name`,`album_id`),"
			  + "KEY `user_id` (`user_id`),"
			  + "KEY `album_id` (`album_id`),"
			  + "CONSTRAINT `pictures_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),"
			  + "CONSTRAINT `pictures_ibfk_2` FOREIGN KEY (`album_id`) REFERENCES `albums` (`id`)"
			+ ") ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;";
	
	public static final String signs = 
	"CREATE TABLE `signs` ("
			+ "`id` int(11) NOT NULL AUTO_INCREMENT,"
			  + "`user_id` int(11) NOT NULL,"
			  + "`sign_time` date NOT NULL,"
			  + "PRIMARY KEY (`id`),"
			  + "UNIQUE KEY `sign_time` (`sign_time`,`user_id`),"
			  + "KEY `user_id` (`user_id`),"
			  + "CONSTRAINT `signs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) "
			+ ") ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;";
}
