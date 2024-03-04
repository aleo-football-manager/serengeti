import pandas as pd
import subprocess
from dotenv import load_dotenv
import os
import json

# Run this command to execute script (from scripts dir):
# python3 ../scripts/contract_flow_test.py

# Load the environment variables from .env file
load_dotenv()

# Your private keys (loaded from .env file)
private_key_challenger = os.getenv('PRIVATE_KEY_CHALLENGER')
private_key_opponent = os.getenv('PRIVATE_KEY_OPPONENT')

# Define a function to execute SnarkOS commands
def execute_snarkos_command(cli_command):
    result = subprocess.run(cli_command, shell=True, capture_output=True, text=True)
    return result

# Function to scan records, adjust start and end block range as needed
# Start default is smart contract deploy block
def scan_records(private_key, start_block=1454013, end_block=1438189):
    scan_command = f"snarkos developer scan --endpoint \"https://node.puzzle.online\" --private-key \"{private_key}\" --start {start_block} --end {end_block}"
    result = execute_snarkos_command(scan_command)

    # Check if the command was executed successfully
    if result.returncode == 0:
        try:
            # Find the starting index of the JSON array
            json_start = result.stdout.index('[')
            # Find the ending index of the JSON array
            json_end = result.stdout.rindex(']') + 1
            # Extract the JSON string based on the found indices
            json_str = result.stdout[json_start:json_end]
            # Parse the JSON string into a Python object
            records = json.loads(json_str)
            
            return records
        
        # return records  # Return the parsed records for further processing
        except (ValueError, json.JSONDecodeError) as e:
            print("Failed to parse JSON output.")
    else:
        print(f"Command failed with error: {result.stderr}")


def propose_game(private_key, wager_record, challenger_wager_amount, sender, challenger, opponent, game_multisig, challenger_messages, challenger_sig, challenger_nonce, challenger_answer, game_multisig_seed):
    challenger_message_fields = ",".join([f"challenger_message_{i+1}: {msg}" for i, msg in enumerate(challenger_messages)])
    command = (
        f"snarkos developer execute 'football_game_v013.aleo' 'propose_game' "
        f"'{{wager_record: {wager_record},challenger_wager_amount: {challenger_wager_amount}u64,sender: {sender},challenger: {challenger},opponent: {opponent},"
        f"game_multisig: {game_multisig},{challenger_message_fields},challenger_sig: {challenger_sig},challenger_nonce: {challenger_nonce},"
        f"challenger_answer: {challenger_answer},game_multisig_seed: {game_multisig_seed}}}' "
        f"--private-key '{private_key}' --query 'https://node.puzzle.online' --broadcast 'https://node.puzzle.online/testnet3/transaction/broadcast' --priority-fee 100000"
    )
    run_snarkos_command(command)

def submit_wager(private_key, opponent_wager_record, key_record, game_req_notification, opponent_messages, opponent_sig):
    opponent_message_fields = ",".join([f"opponent_message_{i+1}: {msg}" for i, msg in enumerate(opponent_messages)])
    command = (
        f"snarkos developer execute 'football_game_v012.aleo' 'submit_wager' "
        f"'{{opponent_wager_record: {opponent_wager_record},key_record: {key_record},game_req_notification: {game_req_notification},"
        f"{opponent_message_fields},opponent_sig: {opponent_sig}}}' "
        f"--private-key '{private_key}' --query 'https://api.explorer.aleo.org/v1' --broadcast 'https://api.explorer.aleo.org/v1/testnet3/transaction/broadcast' --priority-fee 1000000"
    )
    run_snarkos_command(command)

def accept_game(private_key, game_record, opponent_answer, piece_stake_challenger, piece_claim_challenger, piece_stake_opponent, piece_claim_opponent, block_ht):
    command = (
        f"snarkos developer execute 'football_game_v012.aleo' 'accept_game' "
        f"'{{game_record: {game_record},opponent_answer: [{','.join(map(str, opponent_answer))}],piece_stake_challenger: {piece_stake_challenger},"
        f"piece_claim_challenger: {piece_claim_challenger},piece_stake_opponent: {piece_stake_opponent},piece_claim_opponent: {piece_claim_opponent},block_ht: {block_ht}u32}}' "
        f"--private-key '{private_key}' --query 'https://api.explorer.aleo.org/v1' --broadcast 'https://api.explorer.aleo.org/v1/testnet3/transaction/broadcast' --priority-fee 1000000"
    )
    run_snarkos_command(command)


def testing_flow(delay_time):
    scan_records(private_key_challenger, 1438100, 1438190)



testing_flow(100)

print("Game flow execution completed.")