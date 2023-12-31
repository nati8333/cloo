<div class="col-12 col-sm-10 mx-auto">
    <h3>Testing MySQLi driver</h3>
{$trim

    {$import driver.MySQLi $}

    {$set mysqli = new driver\MySQLi() $}
    {$mysqli->connect('cloo_admin', 'ClooAdmin@1234', 'cloo'):noreturn $}

    {$exec 
        if({$@mysqli->connect('cloo_admin', 'ClooAdmin@1234') $})
        {
            {$@mysqli->query('DROP DATABASE IF EXISTS `cloo`;') $};
            {$@mysqli->query('CREATE DATABASE IF NOT EXISTS `cloo`;') $};
            if({$@mysqli->query('USE cloo;') $})
            {
                {$@mysqli->query('CREATE TABLE IF NOT EXISTS `user`(
                        `ID`       INT UNSIGNED NOT NULL AUTO_INCREMENT, 
                        `name`     VARCHAR(64)  NOT NULL, 
                        `age`      SMALLINT UNSIGNED NOT NULL,
                        `password` VARCHAR(256) NOT NULL,
                        
                        PRIMARY KEY(`ID`)
                    )') $};
                {$@mysqli->query('INSERT INTO `cloo`.`user`(`name`, `age`, `password`) VALUES
                    ("admin", 30, "Admin@1234")
                ') $};
            }
        }
    $}

    {$set users={$@mysqli->query('SELECT * FROM `cloo`.`user`;')['rows'] $} $}
    {$html.table({$@users$}) $}

$}
</div>
