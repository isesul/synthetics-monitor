import { journey, step, monitor, expect} from '@elastic/synthetics';

journey('Dashboard Debug', ({ page, context }) => {

  const params = {
    "test":"1.1"
  };

  monitor.use({
    name: '012024_Orienta',
    id: '012024_Orienta',
    schedule: 10,
    tags: ["default", "<required_EM_tags>"],
    privateLocations: ["Netprovider Main"],      
    params: params,
    playwrightOptions: {
        ignoreHTTPSErrors: true,
    }   
  });

  step('Login', async () => {
    try {
      await randomWait();
      await randomError();
      console.log('Everything worked fine');
  } catch (error) {
      console.error('An error occurred:', error.message);
      throw error;
  }
  });
  
  step('Navigate to MetLife Orienta', async () => {
    try {
      await randomWait();
      await randomError();
      console.log('Everything worked fine');
  } catch (error) {
      console.error('An error occurred:', error.message);
      throw error;
  }
  });
  
  step('Navigate to Agenda', async () => {
    try {
      await randomWait();
      await randomError();
      console.log('Everything worked fine');
  } catch (error) {
      console.error('An error occurred:', error.message);
      throw error;
  }
  });
  
  step('Cancel Previous Appointments', async () => {
    try {
      await randomWait();
      await randomError();
      console.log('Everything worked fine');
  } catch (error) {
      console.error('An error occurred:', error.message);
      throw error;
  }
  });
  
  step('Schedule Appointment', async () => {
    try {
      await randomWait();
      await randomError();
      console.log('Everything worked fine');
  } catch (error) {
      console.error('An error occurred:', error.message);
      throw error;
  }
  });
  
  step('Select Specialty', async () => {
    try {
      await randomWait();
      await randomError();
      console.log('Everything worked fine');
  } catch (error) {
      console.error('An error occurred:', error.message);
      throw error;
  }
  });
  
  step('Select Physician', async () => {
    try {
      await randomWait();
      await randomError();
      console.log('Everything worked fine');
  } catch (error) {
      console.error('An error occurred:', error.message);
      throw error;
  }
  });
      
  step('Pick Date', async () => {
    try {
      await randomWait();
      await randomError();
      console.log('Everything worked fine');
  } catch (error) {
      console.error('An error occurred:', error.message);
      throw error;
  }
  });
  
  step('Pick Time', async () => {
    try {
      await randomWait();
      await randomError();
      console.log('Everything worked fine');
  } catch (error) {
      console.error('An error occurred:', error.message);
      throw error;
  }
  });
  
  step('Set Modality', async () => {
    try {
      await randomWait();
      await randomError();
      console.log('Everything worked fine');
  } catch (error) {
      console.error('An error occurred:', error.message);
      throw error;
  }
  });
  
  step('Confirm Appointment', async () => {
    try {
      await randomWait();
      await randomError();
      console.log('Everything worked fine');
  } catch (error) {
      console.error('An error occurred:', error.message);
      throw error;
  }
  });
  
  step('Cancel Appointment', async () => {
    try {
      await randomWait();
      await randomError();
      console.log('Everything worked fine');
  } catch (error) {
      console.error('An error occurred:', error.message);
      throw error;
  }
  });
  
  step('Cancel Appointment Select', async () => {
    try {
      await randomWait();
      await randomError();
      console.log('Everything worked fine');
  } catch (error) {
      console.error('An error occurred:', error.message);
      throw error;
  }
  });
  
  step('Cancel Appointment Confirm', async () => {
    try {
      await randomWait();
      await randomError();
      console.log('Everything worked fine');
  } catch (error) {
      console.error('An error occurred:', error.message);
      throw error;
  }
  });
  
  step('Cancel Appointment End', async () => {
    try {
      await randomWait();
      await randomError();
      console.log('Everything worked fine');
  } catch (error) {
      console.error('An error occurred:', error.message);
      throw error;
  }
  });
  
  step('Logout', async () => {
    try {
  
    } catch (error) {
      console.error('An error occurred:', error.message);
      throw error;
    }
  });
});

async function randomWait() {
  const seconds = Math.floor(Math.random() * 5) + 1;
  console.log(`Waiting ${seconds} seconds...`);
  return new Promise(resolve => setTimeout(resolve, seconds * 1000));
}

async function randomError() {
  return new Promise((resolve, reject) => {
      if (Math.random() < 0.05) {  // 5% de probabilidad de error
          reject(new Error('Random error in async operation'));
      } else {
          resolve('Operation successful');
      }
  });
}
