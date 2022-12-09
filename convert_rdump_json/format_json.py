import json

from pathlib import Path


def main():
    model_data = Path(".").glob("**/*.json")
    for json_file in model_data:
        print(f"Processing {json_file}")

        # Load json data file
        with open(json_file, "r") as f:
            data = json.load(f)
        
        # Check for lists of length 1 which represent integers in the data.R file
        # If found, assign value as integer (not list of integers)
        for key, value in data.items():
            if isinstance(value, list):
                if len(value) == 1:
                    data[key] = value[0]
        
        # Save json data file
        with open(json_file, "w") as f:
            json.dump(data, f)


if __name__ == "__main__":
    main()