import Database.HDBC.Sqlite3
import Data.Char

withdrawl_opt :: String ->Boolean
enq_balance :: String -> Boolean
change_pin_acc  -> Boolean

withdrawl_opt pinStr =
 
  if pinStr /= "" then
 
      putStrLn "Enter amount to withdrawl :"
      amount <- read
 
      cn <- connectSqlite3 "bank_db.db"
      get_m <- cn "SELECT bal from bank WHERE pin=?" [ toSql pinStr ]

      org_amt = get_m-amount

      cn "UPDATE bank SET bal=?" [ toSql org_amt ]
      True

 else
    False
     

enq_balance pinStr =

   if pinStr /= "" then

      cn  <- connectSqlite3 "bank_db.db"
      get_b <- cn "SELECT bal FROM bank WHERE pin ?" [ toSql pinStr ]

      putStrLn "Your remaining balance is : "
      print(get_b)
      True

  else
    False

 change_pin_acc =
 
      cn <- connectSqlite3 "bank_db.db"
      o_pin <- cn "SELECT pin FROM bank"

        putStrLn "Enter old pin : "
        old_pin <- getLine

        if old_pin == o_pin then
            putStrLn "Enter new pin to change : "
             new_pin <- getLine

              cn "UPDATE bank SET pin= ?" [ toSql new_pin ]
               True
      else
          False

get_pin_ip_details -> String

get_pin_ip_details =

   putStrLn "Enter your pin : "
   pin_r <-getLine

   pin_r

main :: IO()

main = do
  putStrLn "1.Withdrawl."
  putStrLn "2.Balance Enquiry."
  putStrLn "3.Change Pin."

  ch <- getChar

  if ch/= "" then

   if ch=="1" then

      pin_str = get_pin_ip_details
      ix = withdrawl_opt pin_str
      if ix==True then
         putStrLn "Sucessfully withdrawl."

   else if ch=="2" then

     pin_str = get_pin_ip_details
       ix = enq_balance pin_str
        if ix==True then
         putStrLn "Balance fetched sucesfully."

  else if ch=="3" then

        ix = change_pin_acc 
         if ix==True then
         putStrLn "Pin changed sucesfully."

  else
    putStrLn "No option selected exited"


       
  