CREATE OR REPLACE PROCEDURE money_transfer (
    account_number IN NUMBER,
    account_name IN CHAR(10),
    p_amount IN NUMBER
) AS
    sender_balance NUMBER;
BEGIN
    -- Check the sender's balance
    SELECT balance INTO sender_balance
    FROM accounts
    WHERE account_number = p_sender_account_number;

    IF sender_balance < p_amount THEN
        -- Insufficient balance, raise an exception
        RAISE_APPLICATION_ERROR(-20001, 'Insufficient balance .');
    ELSE
        -- Deduct the amount from the sender's account
        UPDATE bank_accounts
        SET balance = balance - p_amount
        WHERE account_number = p_sender_account_number;

        -- Add the amount to the receiver's account
        UPDATE bank_accounts
        SET balance = balance + p_amount
        WHERE account_number = p_receiver_account_number;

        -- Record the transaction
        INSERT INTO transaction_history (
            transaction_id,
            sender_account,
            receiver_account,
            amount,
            transaction_date
        ) VALUES (
            transaction_seq.NEXTVAL,
            p_sender_account_number,
            p_receiver_account_number,
            p_amount,
            SYSDATE
        );

        COMMIT;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END money_transfer;
/
