<?php include 'bootstrap/index.php' ?>

<?php
$id = $_GET['id'];

// Fetch the resident's data including their birthdate
$resident = $db
  ->from('residents')
  ->where('id', $id)
  ->first()
  ->exec();

// Check if the resident exists before proceeding
if ($resident) {
    // Calculate the age from birthdate (assuming 'birthdate' is stored in the format YYYY-MM-DD)
    $birthDate = new DateTime($resident['birthdate']);
    $today = new DateTime();
    $age = $today->diff($birthDate)->y;  // This gives the age in years

    // Continue with other database queries
    $captain = $db
        ->from(["tblofficials" => "officials"])
        ->join(["tblposition" => "positions"], "positions.id", "officials.position")
        ->where("positions.id", 4)
        ->first()
        ->select(["name" => "officials.name"])
        ->exec();

    $sec = $db
        ->from(["tblofficials" => "officials"])
        ->join(["tblposition" => "positions"], "positions.id", "officials.position")
        ->where("positions.id", 15)
        ->first()
        ->select(["name" => "officials.name"])
        ->exec();
} else {
    echo "Resident not found.";
    exit;
}
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <?php include 'templates/header.php' ?>
    <title>Certificate of Indigency</title>
    <style>
    @page {
        size: auto;
        margin: 18mm 18mm 18mm 18mm;
    }
    .certification-title {
      font-family: cooper black;
      font-size: 30px;
      color: black;
    }
    </style>
</head>

<body>
    <?php include 'templates/loading_screen.php' ?>
    <div class="wrapper">
        <!-- Main Header -->
        <?php include 'templates/main-header.php' ?>
        <!-- End Main Header -->

        <!-- Sidebar -->
        <?php include 'templates/sidebar.php' ?>
        <!-- End Sidebar -->

        <div class="main-panel">
            <div class="content">
                <div class="panel-header bg-primary-gradient">
                    <div class="page-inner">
                        <div class="d-flex align-items-left align-items-md-center flex-column flex-md-row">
                            <div>
                                <h2 class="text-white fw-bold">Generate Certificate</h2>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="page-inner">
                    <div class="row mt--2">
                        <div class="col-md-12">

                            <?php include "templates/alert.php"; ?>

                            <div class="card">
                                <div class="card-header">
                                    <div class="card-head-row">
                                        <div class="card-title">Certificate of Indigency</div>
                                        <div class="card-tools">
                                            <button class="btn btn-info btn-border btn-round btn-sm" onclick="printDiv('printThis')">
                                                <i class="fa fa-print"></i>
                                                Print Certificate
                                            </button>
                                        </div>
                                    </div>
                                </div>
                                <div class="card-body m-5" id="printThis">
                                    <div class="d-flex flex-wrap justify-content-around">
                                        <div class="text-center mx-5">
                                            <img src="assets/uploads/<?= $brgy_logo ?>" class="img-fluid" width="100">
                                        </div>
                                        <div class="text-center">
                                            <h3 class="fw-bold mb-0" style="font-size: 15px; font-family: Times New Roman;">Republic of the Philippines</h3>
                                            <h3 class="fw-bold mb-0" style="font-size: 15px; font-family: Times New Roman;">Province of <?= ucwords($province) ?></h3>
                                            <h3 class="fw-bold mb-0" style="font-size: 15px; font-family: Times New Roman;"><?= ucwords($town) ?></h3>
                                            <h3 class="fw-bold mb-0" style="font-size: 18px; font-family: Times New Roman;"><?= ucwords($brgy) ?></h3><br>
                                        </div>
                                        <div class="text-center mx-5">
                                            <img src="assets/uploads/<?= $city_logo ?>" class="img-fluid" width="100">
                                        </div>
                                    </div>
                                    <div class="row mt-2">
                                        <div class="col-md-12">
                                            <div class="text-center mt-5">
                                                <h1 class="mt-4 fw-bold" style="font-size: 20px;">OFFICE OF THE PUNONG BARANGAY</h1>
                                            </div>
                                            <div class="text-center">
                                            <h1 class="mt-4 fw-bold mb-5 certification-title"><u>C E R T I F I C A T I O N</u></h1>
                                            </div>
                                            <h2 class="mt-5 fw-bold" style="font-size: 15px;">TO WHOM IT MAY CONCERN:</h2>
                                            <h2 class="mt-3" style="text-indent: 40px; font-size: 15px;">This is to certify that <span class="fw-bold"
                                                style="font-size:15px"><?= ucwords($resident['firstname'] . ' ' . $resident['middlename'] . ' ' . $resident['lastname']) ?></span>,
                                                <span class="fw-bold" style="font-size:15px"><?= $age ?> years old </span>,
                                                <span class="fw-bold" style="font-size:15px"><?= ucwords($resident['gender']) ?></span>, <span class="fw-bold"
                                                style="font-size:15px"><?= ucwords($resident['civilstatus']) ?></span>,
                                            and a resident of <span class="fw-bold"
                                                style="font-size:15px"><?= ucwords($brgy) ?></span> is known to the undersigned as someone who belongs to an indigent family.</h2>
                                            <h2 class="mt-3" style="text-indent: 40px; font-size: 15px">At the he/she in need ASSISTANCE for the following puposes:</h2>
                                            <h2 class="mt-3" style="text-indent: 40px; font-size: 15px">_______Medical needs, hospitalization, maedicines</h2>
                                            <h2 class="mt-3" style="text-indent: 40px; font-size: 15px">_______shelter, Rehabilitation, disaster relief</h2>
                                            <h2 class="mt-3" style="text-indent: 40px; font-size: 15px">_______Funeral of immediate family member</h2>
                                            <h2 class="mt-3" style="text-indent: 40px; font-size: 15px">_____________Others <b>SCHOLARSHIP</b></h2>
                                            <h2 class="mt-3" style="text-indent: 40px; font-size: 15px">This certification is issued to the above name for,</h2>
                                            <h2 class="mt-3" style="text-indent: 40px; font-size: 15px">_______DSWD assistance</h2>
                                            <h2 class="mt-3" style="text-indent: 40px; font-size: 15px">_______PCSO, application</h2>
                                            <h2 class="mt-3" style="text-indent: 40px; font-size: 15px">_______Hospitality requirement</h2>
                                            <h2 class="mt-3" style="text-indent: 40px; font-size: 15px">_______Scholarship</h2>
                                            <h2 class="mt-3" style="text-indent: 40px; font-size: 15px">_____________General information Purposes</h2>
                                            <h2 class="mt-4" style="text-indent: 40px; font-size: 15px">Suso, Santa Maria, Ilocos Sur this <span class="fw-bold"
                                                style="font-size:15px"><?= date('m/d/Y') ?>.
                                            </h2>
                                        </div>
                                        <div class="col-md-10">
                                            <div class="p-3 text-right mr-10" style="margin-top:35px">
                                                <h1 class="fw-bold mb-0 text-uppercase" style="font-size: 16px; text-align: right;"><u><?= ucwords($captain['name']) ?></h1></u>
                                                <p class="mt-0" style="font-size: 13px; text-align: right; text-indent: left;">PUNONG BARANGAY  </p>
                                                <p style="font-family: cooper black; font-size: 15px;"><b>Not valid without official seal</b></p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Modal -->
            <div class="modal fade" id="pment" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
              aria-hidden="true" data-backdrop="static" data-keyboard="false">
              <div class="modal-dialog" role="document">
                <div class="modal-content">
                  <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Create Payment</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                      <span aria-hidden="true">&times;</span>
                    </button>
                  </div>
                  <div class="modal-body">
                    <form method="POST" action="model/save_pment.php">
                      <div class="form-group">
                        <label>Amount</label>
                        <input type="number" class="form-control" name="amount" placeholder="Enter amount to pay" required>
                      </div>

                      <div class="form-group">
                        <label>Date Issued</label>
                        <input type="date" class="form-control" name="date" value="<?= date('Y-m-d') ?>">
                      </div>

                      <div class="form-group">
                        <label>Mode</label>
                        <select class="form-control" name="mode" required>
                          <option selected disabled>Choose payment mode</option>
                          <option value="cash">Cash</option>
                        </select>
                      </div>

                      <div class="form-group">
                        <label>Payment Details(Optional)</label>
                        <textarea class="form-control" placeholder="Enter Payment Details"
                          name="details">Certificate of Indigency Payment</textarea>
                      </div>
                  </div>
                  <div class="modal-footer">
                    <input type="hidden" name="resident_id" value="<?= $_GET['id'] ?>">
                    <input type="hidden" name="create-payment" value="<?= $_GET['id'] ?>">
                    <input type="hidden" name="request_id" value="<?= getBody('request_id', $_GET) ?>">
                    <input type="hidden" name="certificate_id" value="4">
                    <button type="button" class="btn btn-secondary" onclick="goBack()">Close</button>
                    <button type="submit" class="btn btn-primary">Save</button>
                  </div>
                  </form>
                </div>
              </div>
            </div>
            <!-- Main Footer -->
            <?php include 'templates/main-footer.php' ?>
            <!-- End Main Footer -->
        </div>
    </div>
    <?php include 'templates/footer.php' ?>
    <script>
    const urlSearchParams = new URLSearchParams(window.location.search);
    const params = Object.fromEntries(urlSearchParams.entries());

    if (!params['closeModal']) {
        setTimeout(() => {
            $('#pment').modal('show');
        }, 1000);
    }

    function printDiv(divName) {
        var printContents = document.getElementById(divName).innerHTML;
        var originalContents = document.body.innerHTML;

        document.body.innerHTML = printContents;

        window.print();

        document.body.innerHTML = originalContents;
    }
    </script>
</body>

</html>
