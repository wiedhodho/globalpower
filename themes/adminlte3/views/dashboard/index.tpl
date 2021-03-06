{extends file="master/index.tpl"}

{block name='css'}
{/block}

{block name='js'}
<script src="{theme_url()}dist/js/pages/dashboard2.js"></script>
<script>
$(function () {
  'use strict'
  var ticksStyle = {
    fontColor: '#495057',
    fontStyle: 'bold'
  }

  var mode      = 'index'
  var intersect = true
  var $salesChart = $('#sales-chart')
  var salesChart  = new Chart($salesChart, {
    type   : 'bar',
    data   : {
      labels  : [{foreach from=$bulan item=b}'{$b}',{/foreach}],
      datasets: [
        {
          backgroundColor: '#007bff',
          borderColor    : '#007bff',
          data           : [{foreach from=$bulan item=b key=k}{$ketemu=0}{foreach from=$per_bulan item=p}{if $p->bulan==$k-1 && $p->quotation_jenis==0}{$ketemu=$p->banyak}{break}{/if}{/foreach}{$ketemu},{/foreach}]
        },
        {
          backgroundColor: '#ced4da',
          borderColor    : '#ced4da',
          data           : [{foreach from=$bulan item=b key=k}{$ketemu=0}{foreach from=$per_bulan item=p}{if $p->bulan==$k-1 && $p->quotation_jenis==1}{$ketemu=$p->banyak}{break}{/if}{/foreach}{$ketemu},{/foreach}]
        },
        {
          backgroundColor: '#ffc107',
          borderColor    : '#ffc107',
          data           : [{foreach from=$bulan item=b key=k}{$ketemu=0}{foreach from=$per_bulan item=p}{if $p->bulan==$k-1 && $p->quotation_jenis==2}{$ketemu=$p->banyak}{break}{/if}{/foreach}{$ketemu},{/foreach}]
        }
      ]
    },
    options: {
      maintainAspectRatio: false,
      tooltips           : {
        mode     : mode,
        intersect: intersect
      },
      hover              : {
        mode     : mode,
        intersect: intersect
      },
      legend             : {
        display: false
      },
      scales             : {
        yAxes: [{
          // display: false,
          gridLines: {
            display      : true,
            lineWidth    : '4px',
            color        : 'rgba(0, 0, 0, .2)'
          },
          ticks    : $.extend({
            beginAtZero: true,
            stepSize: 1,
          }, ticksStyle)
        }],
        xAxes: [{
          display  : true,
          gridLines: {
            display: false
          },
          ticks    : ticksStyle
        }]
      }
    }
  })
})
</script>
{/block}

{block name='content'}
<div class="content-wrapper">
  <!-- Content Header (Page header) -->
  <div class="content-header">
    <div class="container-fluid">
      <div class="row mb-2">
        <div class="col-sm-6">
          <h1 class="m-0 text-dark">Dashboard
          <a href="{base_url()}quotation/add" class="btn btn-sm btn-primary float-sm-right"><i class="fa fa-plus"></i> Quo Baru</a></h1>
        </div><!-- /.col -->
        <div class="col-sm-6">
          <ol class="breadcrumb float-sm-right">
            <li class="breadcrumb-item"><a href="#">Home</a></li>
            <li class="breadcrumb-item active">Dashboard</li>
          </ol>
        </div><!-- /.col -->
      </div><!-- /.row -->
    </div><!-- /.container-fluid -->
  </div>
  <!-- /.content-header -->

  <!-- Main content -->
  <section class="content">
    <div class="container-fluid">
      <!-- Info boxes -->
      <div class="row">
        <div class="col-12 col-sm-6 col-md-3">
          <div class="info-box">
            <span class="info-box-icon bg-info elevation-1"><i class="fas fa-cog"></i></span>

            <div class="info-box-content">
              <span class="info-box-text">Int & Exterior</span>
              <span class="info-box-number">
                {$interior->banyak}
              </span>
            </div>
            <!-- /.info-box-content -->
          </div>
          <!-- /.info-box -->
        </div>
        <!-- /.col -->
        <div class="col-12 col-sm-6 col-md-3">
          <div class="info-box mb-3">
            <span class="info-box-icon bg-danger elevation-1"><i class="fas fa-thumbs-up"></i></span>

            <div class="info-box-content">
              <span class="info-box-text">Advertising</span>
              <span class="info-box-number">{$adv->banyak}</span>
            </div>
            <!-- /.info-box-content -->
          </div>
          <!-- /.info-box -->
        </div>
        <!-- /.col -->

        <!-- fix for small devices only -->
        <div class="clearfix hidden-md-up"></div>

        <div class="col-12 col-sm-6 col-md-3">
          <div class="info-box mb-3">
            <span class="info-box-icon bg-success elevation-1"><i class="fas fa-shopping-cart"></i></span>

            <div class="info-box-content">
              <span class="info-box-text">Pengadaan Barang</span>
              <span class="info-box-number">{$pengadaan->banyak}</span>
            </div>
            <!-- /.info-box-content -->
          </div>
          <!-- /.info-box -->
        </div>
        <!-- /.col -->
        <div class="col-12 col-sm-6 col-md-3">
          <div class="info-box mb-3">
            <span class="info-box-icon bg-warning elevation-1"><i class="fas fa-users"></i></span>

            <div class="info-box-content">
              <span class="info-box-text">Customer</span>
              <span class="info-box-number">{$cust}</span>
            </div>
            <!-- /.info-box-content -->
          </div>
          <!-- /.info-box -->
        </div>
        <!-- /.col -->
      </div>
      <!-- /.row -->

      <div class="row">
        <div class="col-md-12">
          <div class="card">
            <div class="card-header">
              <h5 class="card-title">Grafik Transaksi Bulanan</h5>

              <div class="card-tools">
                <button type="button" class="btn btn-tool" data-card-widget="collapse">
                  <i class="fas fa-minus"></i>
                </button>
                <button type="button" class="btn btn-tool" data-card-widget="remove">
                  <i class="fas fa-times"></i>
                </button>
              </div>
            </div>
            <!-- /.card-header -->
            <div class="card-body">
              <div class="row">
                <div class="col-md-9">

                  <div class="chart">
                    <!-- Sales Chart Canvas -->
                    <canvas id="sales-chart" height="300" style="height: 300px;"></canvas>
                  </div>
                  <!-- /.chart-responsive -->
                </div>
                <!-- /.col -->
                <div class="col-md-3">
                  <p class="text-center">
                    <strong>Total Tahun {$smarty.now|date_format:"%Y"} ({$dalam})</strong>
                  </p>
                  <div class="progress-group">
                    Interior & Exterior
                    <span class="float-right"><b>{($interior->total/$pembagi)|number_format}</b>/{$total_rupiah|number_format}</span>
                    <div class="progress progress-sm">
                      <div class="progress-bar bg-primary" style="width: {$interior->total/$pembagi/$total_rupiah*100}%"></div>
                    </div>
                  </div>
                  <!-- /.progress-group -->

                  <div class="progress-group">
                    Advertising
                    <span class="float-right">{($adv->total/$pembagi)|number_format}</b>/{$total_rupiah|number_format}</span>
                    <div class="progress progress-sm">
                      <div class="progress-bar bg-danger" style="width: {$adv->total/$pembagi/$total_rupiah*100}%"></div>
                    </div>
                  </div>

                  <!-- /.progress-group -->
                  <div class="progress-group">
                    <span class="progress-text">Pengadaan</span>
                    <span class="float-right">{($pengadaan->total/$pembagi)|number_format}</b>/{$total_rupiah|number_format}</span>
                    <div class="progress progress-sm">
                      <div class="progress-bar bg-warning" style="width: {$pengadaan->total/$pembagi/$total_rupiah*100}%"></div>
                    </div>
                  </div>
                </div>
                <!-- /.col -->
              </div>
              <!-- /.row -->
            </div>
            <!-- ./card-body -->
          </div>
          <!-- /.card -->
        </div>
        <!-- /.col -->
      </div>
      <!-- /.row -->
    </div><!--/. container-fluid -->
  </section>
  <!-- /.content -->
</div>
{/block}
