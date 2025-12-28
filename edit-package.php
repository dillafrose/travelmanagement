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
$sql = "SELECT * FROM tblcustompackages WHERE id = ? AND user_id = ? AND status = 'draft'";
$query = $dbh->prepare($sql);
$query->execute([$packageId, $userId]);
$package = $query->fetch(PDO::FETCH_OBJ);

if(!$package) {
    $_SESSION['error'] = "Package not found or cannot be edited";
    header('location:view-custom-packages.php');
    exit();
}

// Get all components
$sql = "SELECT * FROM tblpackagecomponents WHERE is_active = 1";
$query = $dbh->prepare($sql);
$query->execute();
$allComponents = $query->fetchAll(PDO::FETCH_OBJ);

// Get selected components
$sql = "SELECT component_id, quantity FROM tblpackage_items WHERE package_id = ?";
$query = $dbh->prepare($sql);
$query->execute([$packageId]);
$selectedComponents = [];
foreach($query->fetchAll(PDO::FETCH_OBJ) as $item) {
    $selectedComponents[$item->component_id] = $item->quantity;
}

// Handle form submission
if(isset($_POST['update_package'])) {
    $packageName = $_POST['package_name'];
    $newComponents = $_POST['components'] ?? [];
    
    // Calculate new total price
    $totalPrice = 0;
    foreach($newComponents as $componentId => $quantity) {
        if($quantity > 0) {
            foreach($allComponents as $comp) {
                if($comp->id == $componentId) {
                    $totalPrice += $comp->price * $quantity;
                    break;
                }
            }
        }
    }
    
    try {
        $dbh->beginTransaction();
        
        // Update package
        $sql = "UPDATE tblcustompackages SET name = ?, total_price = ? WHERE id = ?";
        $query = $dbh->prepare($sql);
        $query->execute([$packageName, $totalPrice, $packageId]);
        
        // Delete old components
        $sql = "DELETE FROM tblpackage_items WHERE package_id = ?";
        $query = $dbh->prepare($sql);
        $query->execute([$packageId]);
        
        // Insert new components
        foreach($newComponents as $componentId => $quantity) {
            if($quantity > 0) {
                $sql = "INSERT INTO tblpackage_items (package_id, component_id, quantity) VALUES (?, ?, ?)";
                $query = $dbh->prepare($sql);
                $query->execute([$packageId, $componentId, $quantity]);
            }
        }
        
        $dbh->commit();
        $_SESSION['success'] = "Package updated successfully!";
        header('location:view-custom-packages.php');
        exit();
    } catch (Exception $e) {
        $dbh->rollBack();
        $_SESSION['error'] = "Error updating package: " . $e->getMessage();
    }
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Package</title>
    <?php include('includes/header-scripts.php'); ?>
</head>
<body>
    <?php include('includes/header.php'); ?>

    <div class="container">
        <h2>Edit Package</h2>
        
        <?php if(isset($_SESSION['error'])): ?>
            <div class="alert alert-danger"><?php echo $_SESSION['error']; unset($_SESSION['error']); ?></div>
        <?php endif; ?>
        
        <form method="post">
            <div class="form-group">
                <label>Package Name</label>
                <input type="text" name="package_name" class="form-control" value="<?php echo $package->name; ?>" required>
            </div>
            
            <h4>Select Components</h4>
            
            <div class="row">
                <?php foreach($allComponents as $component): ?>
                    <div class="col-md-4 mb-3">
                        <div class="card">
                            <div class="card-body">
                                <h5><?php echo $component->name; ?></h5>
                                <p><?php echo $component->description; ?></p>
                                <p>Price: $<?php echo $component->price; ?></p>
                                <input type="number" name="components[<?php echo $component->id; ?>]" 
                                       min="0" max="10" 
                                       value="<?php echo $selectedComponents[$component->id] ?? 0; ?>" 
                                       class="form-control">
                            </div>
                        </div>
                    </div>
                <?php endforeach; ?>
            </div>
            
            <button type="submit" name="update_package" class="btn btn-primary">Update Package</button>
            <a href="view-custom-packages.php" class="btn btn-secondary">Cancel</a>
        </form>
    </div>
</body>
</html>