<?php
session_start();
include('includes/config.php');

if(strlen($_SESSION['alogin']) == 0) {    
    header('location:index.php');
    exit();
} else {
    // Check if user_id is set in session (if needed)
    // If you're using admin session, you might not need user_id for admin views
    // If this is for users, you should have a user session check
    
    // For admin viewing all custom packages:
    $sql = "SELECT cp.*, tp.PackageName as base_package_name, u.FullName as user_name
            FROM tblcustompackages cp
            LEFT JOIN tbltourpackages tp ON cp.base_package_id = tp.PackageId
            LEFT JOIN tblusers u ON cp.user_id = u.id
            ORDER BY cp.id DESC";
    
    // If this is for users to view their own packages:
    /*
    if(isset($_SESSION['user_id'])) {
        $userId = $_SESSION['user_id'];
        $sql = "SELECT cp.*, tp.PackageName as base_package_name 
                FROM tblcustompackages cp
                LEFT JOIN tbltourpackages tp ON cp.base_package_id = tp.PackageId
                WHERE cp.user_id = ?
                ORDER BY cp.id DESC";
    }
    */
    
    $query = $dbh->prepare($sql);
    
    // If using user-specific query:
    // $query->execute([$userId]);
    
    // For admin view (all packages):
    $query->execute();
    
    $packages = $query->fetchAll(PDO::FETCH_OBJ);
?>
<!DOCTYPE HTML>
<html>
<head>
<title>TripIN - Custom Packages</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>
<!-- Bootstrap Core CSS -->
<link href="css/bootstrap.min.css" rel='stylesheet' type='text/css' />
<!-- Custom CSS -->
<link href="css/style.css" rel='stylesheet' type='text/css' />
<link rel="stylesheet" href="css/morris.css" type="text/css"/>
<!-- Graph CSS -->
<link href="css/font-awesome.css" rel="stylesheet"> 
<!-- jQuery -->
<script src="js/jquery-2.1.4.min.js"></script>
<!-- //jQuery -->
<link href='//fonts.googleapis.com/css?family=Roboto:700,500,300,100italic,100,400' rel='stylesheet' type='text/css'/>
<link href='//fonts.googleapis.com/css?family=Montserrat:400,700' rel='stylesheet' type='text/css'>
<!-- lined-icons -->
<link rel="stylesheet" href="css/icon-font.min.css" type='text/css' />
</head> 
<body>
   <div class="page-container">
   <!--/content-inner-->
<div class="left-content">
       <div class="mother-grid-inner">
            <?php include('includes/header.php');?>

            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="dashboard.php">Home</a><i class="fa fa-angle-right"></i>Custom Packages</li>
            </ol>

            <div class="inner-block">
                <div class="inbox">
                    <h2>Custom Packages</h2>
                    
                    <?php if(isset($_SESSION['msg'])): ?>
                        <div class="alert alert-success"><?php echo htmlentities($_SESSION['msg']); unset($_SESSION['msg']); ?></div>
                    <?php endif; ?>
                    
                    <div class="col-md-12 mailbox-content  tab-content tab-content-in">
                        <div class="tab-pane active" id="view-all">
                            <?php if(count($packages) > 0): ?>
                                <table class="table table-striped table-bordered">
                                    <thead>
                                        <tr>
                                            <th>Package Name</th>
                                            <th>Based On</th>
                                            <th>User</th>
                                            <th>People</th>
                                            <th>Transport</th>
                                            <th>Status</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <?php foreach($packages as $package): ?>
                                            <tr>
                                                <td><?php echo htmlspecialchars($package->name); ?></td>
                                                <td><?php echo $package->base_package_name ? htmlspecialchars($package->base_package_name) : 'Custom'; ?></td>
                                                <td><?php echo isset($package->user_name) ? htmlspecialchars($package->user_name) : 'N/A'; ?></td>
                                                <td><?php echo htmlspecialchars($package->people_count); ?></td>
                                                <td><?php echo ucfirst(htmlspecialchars($package->transport_type)); ?></td>
                                                <td>
                                                    <span class="badge badge-<?php 
                                                        echo $package->status == 'confirmed' ? 'success' : 
                                                             ($package->status == 'cancelled' ? 'danger' : 'warning');
                                                    ?>">
                                                        <?php echo ucfirst(htmlspecialchars($package->status)); ?>
                                                    </span>
                                                </td>
                                                <td>
                                                    <a href="view-package.php?id=<?php echo htmlspecialchars($package->id); ?>" class="btn btn-sm btn-info">View</a>
                                                    <?php if($package->status == 'draft'): ?>
                                                        <a href="edit-package.php?id=<?php echo htmlspecialchars($package->id); ?>" class="btn btn-sm btn-primary">Edit</a>
                                                    <?php endif; ?>
                                                    <a href="delete-package.php?id=<?php echo htmlspecialchars($package->id); ?>" class="btn btn-sm btn-danger" onclick="return confirm('Are you sure you want to delete this package?')">Delete</a>
                                                </td>
                                            </tr>
                                        <?php endforeach; ?>
                                    </tbody>
                                </table>
                            <?php else: ?>
                                <div class="alert alert-info">No custom packages found.</div>
                            <?php endif; ?>
                        </div>
                    </div>
                    <div class="clearfix"></div>
                </div>
            </div>
            
        
        </div>
    </div>
    
    <?php include('includes/sidebarmenu.php');?>
    <div class="clearfix"></div>
    
    <!-- JavaScript -->
    <script src="js/jquery.nicescroll.js"></script>
    <script src="js/scripts.js"></script>
    <script src="js/bootstrap.min.js"></script>
</body>
</html>
<?php } ?>
