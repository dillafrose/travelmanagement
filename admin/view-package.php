<?php
session_start();
include('includes/config.php');

if(!isset($_SESSION['login'])) {
    header('location:index.php');
    exit();
}

if(!isset($_GET['id'])) {
    header('location:view-custom-packages.php');
    exit();
}

$packageId = $_GET['id'];
$userId = $_SESSION['user_id'];

// Get package details
$sql = "SELECT * FROM tblcustompackages WHERE id = ? AND user_id = ?";
$query = $dbh->prepare($sql);
$query->execute([$packageId, $userId]);
$package = $query->fetch(PDO::FETCH_OBJ);

if(!$package) {
    $_SESSION['error'] = "Package not found";
    header('location:view-custom-packages.php');
    exit();
}

// Get package components
$sql = "SELECT pc.*, pi.quantity 
        FROM tblpackage_items pi
        JOIN tblpackagecomponents pc ON pi.component_id = pc.id
        WHERE pi.package_id = ?";
$query = $dbh->prepare($sql);
$query->execute([$packageId]);
$components = $query->fetchAll(PDO::FETCH_OBJ);
?>

<!DOCTYPE html>
<html>
<head>
    <title>Package Details</title>
    <?php include('includes/header-scripts.php'); ?>
</head>
<body>
    <?php include('includes/header.php'); ?>

    <div class="container">
        <h2><?php echo $package->name; ?></h2>
        
        <div class="row">
            <div class="col-md-6">
                <div class="card">
                    <div class="card-body">
                        <h4>Package Summary</h4>
                        <p><strong>Status:</strong> <?php echo ucfirst($package->status); ?></p>
                        <p><strong>Total Price:</strong> $<?php echo $package->total_price; ?></p>
                        <p><strong>Created On:</strong> <?php echo date('M d, Y', strtotime($package->created_at)); ?></p>
                    </div>
                </div>
            </div>
            
            <div class="col-md-6">
                <div class="card">
                    <div class="card-body">
                        <h4>Package Components</h4>
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>Component</th>
                                    <th>Quantity</th>
                                    <th>Price</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php foreach($components as $component): ?>
                                    <tr>
                                        <td><?php echo $component->name; ?></td>
                                        <td><?php echo $component->quantity; ?></td>
                                        <td>$<?php echo $component->price * $component->quantity; ?></td>
                                    </tr>
                                <?php endforeach; ?>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        
        <a href="view-custom-packages.php" class="btn btn-secondary mt-3">Back to Packages</a>
    </div>

</body>
</html>