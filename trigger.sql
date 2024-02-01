CREATE OR REPLACE TRIGGER money_transfer_trigger
AFTER INSERT ON transaction_history
FOR EACH ROW
DECLARE
    sender_balance NUMBER;
    receiver_balance NUMBER;
BEGIN
    -- Get the sender's balance
    SELECT balance INTO sender_balance
    FROM transaction
    WHERE acc_no = :new.sender_acc_no;

    -- Get the receiver's balance
    SELECT balance INTO receiver_balance
    FROM transaction
    WHERE acc_no = :new.receiver_acc_no;

    -- Update the sender's balance
    UPDATE transaction
    SET balance = sender_balance - :new.amount
    WHERE acc_no = :new.sender_acc_no;

    -- Update the receiver's balance
    UPDATE transaction
    SET balance = receiver_balance + :new.amount
    WHERE acc_no = :new.receiver_acc_no;

    COMMIT;
END;
/